# Check if the required arguments are provided
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <image-name-and-tag>"
  exit 1
fi

if [ -z "$INSTALLER_USERNAME" ]; then
  echo "Please set INSTALLER_USERNAME environment variable."
  exit 1
fi

if [ -z "$INSTALLER_PASSWORD" ]; then
  echo "Please set INSTALLER_PASSWORD environment variable."
  exit 1
fi

INSTALLER_PRODUCTS=e2ei/11/WSC_11.1.0.0.633/SCG/SCGCommon,e2ei/11/SSX_TLS_11.1.0.0.80/API/SSX_TLS,e2ei/11/MFT_SPM_11.1.0.0.703/MFT/MFTspm,e2ei/11/WFF_10.7.0.0.30/IntegrationServer/WFF,e2ei/11/TPS_11.1.0.0.322/SCG/tppServlet,e2ei/11/MWS_11.1.0.0.825/portal/MWSSharedLib,e2ei/11/TPS_11.1.0.0.322/SCG/tppAnt,e2ei/11/WMN_11.1.0.0.181/WmMonitor/Monitor,e2ei/11/WSS_11.1.0.0.1375/SCG/WSSCore,e2ei/11/TPS_11.1.0.0.322/SCG/tppSwagger,e2ei/11/BR_11.1.0.0.37/Broker/PIFSharedBundles,e2ei/11/TPS_11.1.0.0.322/SCG/tppParsers,e2ei/11/TPS_11.1.0.0.322/Platform/TPS,e2ei/11/LIC_5.7.6.0.161/LICSharedLibsJava/LICSharedLibsJava,e2ei/11/MWS_11.1.0.0.825/integrationServer/MWSCentralUserManagement,e2ei/11/WAR_SPM_11.1.0.0.601/WAR/WARspm,e2ei/11/MTA_11.1.0.0.843/Metering/MTAAgent,e2ei/11/SJP_17.0.12.0.125/Infrastructure/sjp,e2ei/11/IS_11.1.0.0.1136/CDC/PIEEmbeddedCdc,e2ei/11/DDJ_11.1.0.0.93/DDJ/WSIddj,e2ei/11/IS_11.1.0.0.1136/integrationServer/PIECore,e2ei/11/TPS_11.1.0.0.322/SCG/tppModelling,e2ei/11/WIS_11.1.0.0.72/Infrastructure/WISSharedBundles,e2ei/11/WIS_11.1.0.0.72/Infrastructure/WISSharedLibs,e2ei/11/ZSL_11.1.0.0.19/Platform/ZSLSharedBundles,e2ei/11/MWS_11.1.0.0.825/portal/CAFRLib,e2ei/11/WGL_8.0.0.9000.223/Infrastructure/WGLSharedLibs,e2ei/11/TPS_11.1.0.0.322/SCG/tppSpring,e2ei/11/IS_11.1.0.0.1136/integrationServer/ISspm,e2ei/11/BR_11.1.0.0.37/Broker/BrokerJMSShared,e2ei/11/IS_11.1.0.0.1136/integrationServer/ISSharedBundles,e2ei/11/TPS_11.1.0.0.322/SCG/tppCommons,e2ei/11/DDJ_11.1.0.0.93/DDJ/TPSddj,e2ei/11/LAR_11.1.0.0.861/Platform/LARSharedBundles,e2ei/11/OSGI_11.1.0.0.1262/Platform/OSGI,e2ei/11/ACDL_11.1.0.0.1434/ACDL/ACDLDeployerSharedBundle,e2ei/11/NUM_11.1.0.0.2533/UniversalMessaging/NUMSharedLibs,e2ei/11/WAR_11.1.0.0.293/IntegrationServer/WAR,e2ei/11/LIC_5.7.6.0.161/LICRepository/LICRepository,e2ei/11/MWS_11.1.0.0.825/MWS/MWSCommonDirectoryService,e2ei/11/TPS_11.1.0.0.322/SCG/loggers,e2ei/11/SPM_11.1.0.0.1693/Platform/SPM,e2ei/11/TPL_11.1.0.0.39/License/license,e2ei/11/IS_11.1.0.0.1136/integrationServer/integrationServerMigrationFrameworkLib,e2ei/11/TPS_11.1.0.0.322/SCG/tppDB,e2ei/11/TPS_11.1.0.0.322/SCG/tppGf,e2ei/11/TPS_11.1.0.0.322/SCG/tppWS,e2ei/11/TPS_11.1.0.0.322/SCG/tppSEC,e2ei/11/MFT_11.1.0.0.804/MFT/MFT,e2ei/11/BAM_11.1.0.0.798/optimize/optimizeSharedLib,e2ei/11/IS_11.1.0.0.1136/integrationServer/integrationServer,e2ei/11/WMN_SPM_11.1.0.0.692/WmMonitor/WMNspm,e2ei/11/TPS_11.1.0.0.322/SCG/tppMisc,e2ei/11/MWS_SPM_11.1.0.0.825/portal/MwsSpmIsCds,e2ei/11/CMP_11.1.0.0.133/CMP/CMP_API,e2ei/11/TES_4.4.1.0.249/TES/TESCommon,e2ei/11/TPS_11.1.0.0.322/SCG/jsw,e2ei/11/IS_11.1.0.0.1136/integrationServer/PIEContainerExternalRDBMS,e2ei/11/DCC_11.1.0.0.26/CDC/DatabaseComponentConfiguratorCore,e2ei/11/MFT_11.1.0.0.804/MFT/MFTSupport,e2ei/11/LIC_5.7.6.0.161/LICUtil/LICUtil,e2ei/11/TPS_11.1.0.0.322/SCG/tppGfJaxb
INSTALLER_FIXES=wMFix.TPS.DataModelling_11.1.0.0001-0355,wMFix.SJP.Java64.LNXAMD64_11.1.0.0362-0184,wMFix.OPT.optimizeSharedLib_11.1.0.0001-0862,wMFix.FlatFile_10.7.0.0015-0002,wMFix.TPP.DataModelling_11.1.0.0003-0359,wMFix.integrationServer.Core_11.1.0.0003-0015,wMFix.WGL.commonlib_10.15.0.0001-0256,wMFix.OSGI.Platform_11.1.0.0001-0115,wMFix.TPP.DataModelling.LNXAMD64_11.1.0.0002-0354,wMFix.ALL.SSL.LNXAMD64_11.1.0.0001-0095,wMFix.TPP.DataDirect_11.1.0.0002-0141,wMFix.TPS.XMLTools_11.1.0.0001-0369,wMFix.LARSharedBundles_11.1.0.0001-0974,wMFix.MFTServer_11.1.0.0001-0827,wMFix.ALL.SIN_11.1.0.0001-1067,wMFix.DDJ.DataDirect_11.1.0.0002-0138,wMFix.SCGCommon.IS_11.1.0.0003-0015,wMFix.SCGCommon.glue_10.1.0.0002-0003,wMFix.MeteringAgent_11.1.0.0002-0907,wMFix.MWSCentralUserManagement_11.1.0.0001-0003,wMFix.SCGCommon.MWS_11.1.0.0002-0060,wMFix.TPP.Parsers_11.1.0.0001-0367

podman build --platform linux/amd64 \
    --build-arg INSTALLER_USERNAME=${INSTALLER_USERNAME} \
    --build-arg INSTALLER_PASSWORD=${INSTALLER_PASSWORD} \
    --build-arg INSTALLER_PRODUCTS=${INSTALLER_PRODUCTS} \
    --build-arg INSTALLER_FIXES=${INSTALLER_FIXES} \
    -t $1 .