Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B5D1B86DB;
	Wed,  7 Aug 2024 11:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723030498; cv=fail; b=hpADlvoS9pTLDW2lQrjJUkCSNH9qoN4B0dv33/RFkAmAhPT95i1bhuh2OvuyfWuKsrpJD9qtL+QSTMcXNHmV/tsB8RxNrcxqTnfah/Ygj2bzNbBiDSGufH4nWZ39LlzYPvcJuE2cEWYhH2NvMYoqWQ/npPmSkLLRglDIxHmC+5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723030498; c=relaxed/simple;
	bh=4cxbG2WOFLA0oItlAWjXXdix/PD0bFS1Cr9SmeVZ8Tc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Koyel8ZqG/RUPzmESrFK4b+kDV6v1p6Z5Mq5Uwk00bmvpAt9RwcdGfLqySIXeGHmnUMZIIBgDzkITPKF5LoD6egxIkjVvJvbCmxWyAzLtFVbIF5GIOQNZr6yfxFKqerEPnbsRaCG01BAAcusNVAyQ92PURLhy+tLVBaBf/evumQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ZUq4ZX1Z; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=p1PRLtaO; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ZUq4ZX1Z";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="p1PRLtaO"
X-UUID: 0bd5a05054b111ef87684b57767b52b1-20240807
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=4cxbG2WOFLA0oItlAWjXXdix/PD0bFS1Cr9SmeVZ8Tc=;
	b=ZUq4ZX1ZUni8CyBwFl0xhlR1J9LFE0qiwELLx1P3haeqT2VIPLxoK2vPoEnj5UGGisbQChLWZGpU4xkWkNRjOI9RMEk4akdS4OwlufXaZVT+q429Dk8bFcW/cV5lRYKQsT/wa/rlGTd8oMlBo+O3aWiLIKJhV2EACbw2nvXk4lU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:c78a1c33-f8ce-4818-8088-1bfb3f19bb96,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:e6d4d73e-6019-4002-9080-12f7f4711092,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 0bd5a05054b111ef87684b57767b52b1-20240807
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <tze-nan.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 492282346; Wed, 07 Aug 2024 19:34:45 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 7 Aug 2024 19:34:46 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 7 Aug 2024 19:34:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EJfiA4Py+T8+NShaEMXHcl2wfPhTv2MRjfcXjFUVAJ60VbGwCrAS314APxvjImYSCvGr0DmXqBOIT2kOodD0X5/oUeEi3C2saXZWkEaTX4McNaIBTH0gHme83I0shzf65puGSb2QMyQOet61G95NNaS1bfQzfTiNKdVQabvbfC3aubbS+C8KIcYtP579UF66Io1lQGNVPH0vZu6eHFLtH04BxmhzOhEosoRrSKjxu370qIZDxaX7TE080x1VlH/zMkPWYNmq06797uj25ps28S8TCMI7wW8KzFOzfPbqTocrmzBH4ejg4tCQfM8W119EXHT7kaQ6o/XaSCKCkTehAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4cxbG2WOFLA0oItlAWjXXdix/PD0bFS1Cr9SmeVZ8Tc=;
 b=CbfVVRowXfDCwi8wmNMhm0437jkW8UPZmbscltIR8UWS4QIXl58a7pixHVb0WYRMStKf2+HGcN5b0LRV/3Yhfn7Dt5p11h4BS7gR/1eNGANPMSSOXmNV1R3n05zv7bAWNkjtRLh52Qqlimjgqyza9t7YTrZq9yoEqZ/2I22rtKiFJWFyAEgJkk8UXNjwx0UCCeuHdOBikvZzCMGq8eM2nS3GKbXIvCdLjy/NuSr1lgzmRS0TAaAEoPlDyU7P5Ono44NhIJU1V+5Q9r3wHqgnSXUYoIL9sE+0/KU5PaTYYCpiyUIAIqVFmkXkgLMayDUmIKBDbtWdXAcqxODLz8XBCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4cxbG2WOFLA0oItlAWjXXdix/PD0bFS1Cr9SmeVZ8Tc=;
 b=p1PRLtaOY6Aahf3DMct+fd26qiNGW7wse7sc7+ODEZDO1ifoKQv/CNJAdDUyes25BCGqgRHMm75JwkMt9VSlXBIZ9CpAvy97eV96LVlYMBCIFlwn/7iMCDfhtP4vIzt85vGRklFzYR+FXfTillwNW1WT5dbGMqvJFW+KT2ahW1k=
Received: from TYZPR03MB7183.apcprd03.prod.outlook.com (2603:1096:400:33a::11)
 by KL1PR03MB8002.apcprd03.prod.outlook.com (2603:1096:820:fc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Wed, 7 Aug
 2024 11:34:43 +0000
Received: from TYZPR03MB7183.apcprd03.prod.outlook.com
 ([fe80::5a8:982:e044:3350]) by TYZPR03MB7183.apcprd03.prod.outlook.com
 ([fe80::5a8:982:e044:3350%6]) with mapi id 15.20.7784.020; Wed, 7 Aug 2024
 11:34:43 +0000
From: =?utf-8?B?VHplLW5hbiBXdSAo5ZCz5r6k5Y2XKQ==?= <Tze-nan.Wu@mediatek.com>
To: "rostedt@goodmis.org" <rostedt@goodmis.org>
CC: "zanussi@kernel.org" <zanussi@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>,
	=?utf-8?B?Q2hlbmctSnVpIFdhbmcgKOeOi+ato+edvyk=?=
	<Cheng-Jui.Wang@mediatek.com>, wsd_upstream <wsd_upstream@mediatek.com>,
	=?utf-8?B?Qm9idWxlIENoYW5nICjlvLXlvJjnvqkp?= <bobule.chang@mediatek.com>,
	"mhiramat@kernel.org" <mhiramat@kernel.org>, "eric-yc.wu@mediatek.com"
	<eric-yc.wu@mediatek.com>, "mathieu.desnoyers@efficios.com"
	<mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH RESEND] tracing: Fix overflow in get_free_elt()
Thread-Topic: [PATCH RESEND] tracing: Fix overflow in get_free_elt()
Thread-Index: AQHa5vyeyrV7EinAd0uhrD7m7izVyrIaoukAgAEKtAA=
Date: Wed, 7 Aug 2024 11:34:43 +0000
Message-ID: <52e8ccc5dd82668c17877c97fb96f255dc2e7052.camel@mediatek.com>
References: <20240805055922.6277-1-Tze-nan.Wu@mediatek.com>
	 <20240806154008.502b6c7d@gandalf.local.home>
In-Reply-To: <20240806154008.502b6c7d@gandalf.local.home>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7183:EE_|KL1PR03MB8002:EE_
x-ms-office365-filtering-correlation-id: a0ffb74c-3f62-4304-4df9-08dcb6d4eeef
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?K09CSVQ1RjVHN2p1anBUK1dPbDl2YW0rQlVUWWlZNjgyWVVxY1NYbW4rSkMr?=
 =?utf-8?B?NTN6eE1Lck5WcWRFMUlaUzhmdjFjMEhoY2JCQXNuT09ycW1rWmtWSG8xMnNn?=
 =?utf-8?B?MkJFc1NNVzNmMk95RGVqdGdzWktsOHRJZnJ0SGFkaExjQ3RBZVNVcDR6ZW00?=
 =?utf-8?B?TUdrdytqZW9LWCsrbFE1UGhxSW1Hb3R3RXFIbStWUzdKUkFqdWpNNytlNVZ3?=
 =?utf-8?B?cUIzVTNoSkUzS0dwSWg1dG5JRXorRWt5MUpDb0tBVTEza3J6MjRoTHlSN3VY?=
 =?utf-8?B?RDY2MnY5QUZ4YWxNRmxoUXU5WXFDcnI0NW9hYmhmLzhFaUlscnFhYW9VckNJ?=
 =?utf-8?B?dUtqT0gyK1BSUnNxSWsya3E2QU40ZFhCYytRc1VOVi95SnFVY0pYWmJ3b1Zt?=
 =?utf-8?B?U05MTW5TMlNYakg5Y2MxajBtQkE1VlNmeFB0YzNuSW5sODVwQVJPSDZEUWFp?=
 =?utf-8?B?dmV3T0hQTWxWYW82dlNsL2EwNy9LVGt5VW8vRHlyN2tkUDdsRzFaUi9VZy9q?=
 =?utf-8?B?NUpkbzcycWNpM3dJc0dtWFYvbHkrVWltajBuMFA1M0xNdTlCVzFMNHprS0tx?=
 =?utf-8?B?VFJWdmozWXhaMEpzcEp5SWhHQ3k3d0ZaSmt5U0I4dkIzbHdKSmdDUWhWaG15?=
 =?utf-8?B?VlJPL0YyYStJMXJCTkcrUTlRcGxCdmcwMHcwRVB0d3NPKytFaWFXekR3SU9v?=
 =?utf-8?B?dXVUc3FNUXNBVVl4ZXhFcEYwSTdzeWhkL0IzNW1rZ1Q2QnozVTRJdVlVM1da?=
 =?utf-8?B?ZHlxSXlKUTBsVTBwOG9iMjRUL2JFbUF6SHRLWXhIckQ4ZnJCKzFacXB6bmFU?=
 =?utf-8?B?M3dxR1ptalJjTVk3ekxjUDlvV2FJNG9TdnlQSmVQRU5tQS9kNVNWeUI0YS9Z?=
 =?utf-8?B?ZnZxemtxdDRtU1RUL2dMMThFM2ZWRU5TNTg5Y3lLcUtxY3lDeStvUnZyaVFz?=
 =?utf-8?B?OVdIZFdJeHUxdWh0bExDakd2UW1ORzBuU3NPbDhVZnk1aWoza2I5YzYyUmFi?=
 =?utf-8?B?SmJ1L0FjVElQN3Z6R3ZKMlJTTUdndFJDeTdzZi8vQXlHQTAxRXhrbEZvcTRu?=
 =?utf-8?B?azVGY1ZNMEZGeVJaY1FvNGFEWXlqMk44bC9oMmtvRG5nY01CSGN0R1ExbUFZ?=
 =?utf-8?B?RUZIRVR6TXR4bkN6dDd4azBQbVJsYnc5ZTN4NVZuRkRUK21uQ0RGdmh1anNC?=
 =?utf-8?B?WmswTFM5VHFaQmtCamFWYmJ5V2c1aitVellXUTVMdDhidEVWR0N5azJyRklV?=
 =?utf-8?B?a2hkcVF1Z2R3MjdLRS9GVHBBYTcyOGN0SWlNZzBJa0V3bGVQdFFCSWR5Q0tx?=
 =?utf-8?B?dVBYeG81YzM4b1VkaG5hT2d4bk1rQXRLRDNXWFhXQjJHeUpZdHIzL29QWjdw?=
 =?utf-8?B?WUpaSlVQTDdlVkFEcFlIbTFrb1VLbGJqcHpQeTNTa1V5dHhLVjUrSWtsSkkw?=
 =?utf-8?B?cnFYeC9JVlUvZEZvT0JXU1N5Zkg5WmVZd08rLzBCN0hMK2VPQ0poYU9aSThJ?=
 =?utf-8?B?K2xPUmlqVElodmpoN094U3k1Q0dWUFVwaERTNnhTQThQM1h3MEl6elVIZ2R6?=
 =?utf-8?B?cndSSnVFL0VCWWlmM1RrU0pQcUx0cmN2SnNFWTQ1QmZaTHVKVUh0bmhmZHgw?=
 =?utf-8?B?ZGhvWUF2a2NLQUJob2IyTFpQZlpvUHhBaStFSUhDQUZkdGhyUDZNRWhDLzd6?=
 =?utf-8?B?eTZ6VU9heWpvblV1eDdqb2ZzUm5PS3FNb29USHZhVUpWTUtKZlFNY2VEdlFv?=
 =?utf-8?B?RjRsTjdNR0xZZURXb0xKeGlkRGJkVUpTbGNZOEtBdnprb09FV05wVnZEd1VP?=
 =?utf-8?B?bnE5akc3Y0VvbmFUL0FHUUVxdlhpTnk2WEx3eTlGei9Bd3VWRVNBWTdNR3ha?=
 =?utf-8?B?Z21KWkJTV2NPbVNCWHcwQ2t3Mm5FTWFwQkhraGt1ay84ZFE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7183.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVlhaUNuamxZVGFUd0xGNVE3N3B4WjZzeE9kdUNlT2pzYW9yblI4bmRvUTQ2?=
 =?utf-8?B?dHpkU1RuYmk2djcvbHFDODNSMU9VZ1VVNXMrVHM1MXFKZkRZTWYyZ3QrZ0tU?=
 =?utf-8?B?RE9ZZkxoVXU1RnJMZmFDR0k0dzB1RW1FMVB5Sk16S1VUaHNVa3FXSEg0V1Bx?=
 =?utf-8?B?aXdSdXdXeVBINm9aNUhXbkt5dXVXQmp3eGNOMWNqNGpxV25LeHFnK0JEUWo2?=
 =?utf-8?B?eFIyQklVWlUyNFRhcG55ajZ5ejNWUTdDVktJQytjK0pJMlE2YTNQazArNWpP?=
 =?utf-8?B?K1Rqck5UQXM4RUV1d3BYSHdPNmM1NHdheGtIWHplNlpOWWNTVGV1M1JZUCtZ?=
 =?utf-8?B?RkwxQXlnbk5GRy85TGtDbCtjby9HOTVBQmxpcmV6VGl4VGxqbmZrWGg0S24w?=
 =?utf-8?B?QlErSlBZN1NsM1pxMGVaV0pGODZPMG9BNENoMERDK203UGFkdmljZlh6R3hh?=
 =?utf-8?B?aXRuZTZOaDZwSWd0VElCNHdKbVAvOWJsZjRyVXZkYkFRMm4zMkdudmFKc1d5?=
 =?utf-8?B?ZlJJY0tieXRFamdoTnUvUGpxLzJWeDhYdWNkZWIxZVJMQ2o0WmVLcmxQQ2p5?=
 =?utf-8?B?RXlaUFkyakpST3ZnTmNwV3pkWEtabGE1aUN5eCtTSEs5MkpsUFVncUd2RFND?=
 =?utf-8?B?RklDTDFPM2NraWxOdFRGSVJyRHIvemxYeG85UHFhWmtySzlMdlY5eUQxS05V?=
 =?utf-8?B?bldQSUhVd2JJL21MOVpjVmh6Zmw4QVYvcHNEQVJOeTFJTzJVdXlKcnpRalo1?=
 =?utf-8?B?byttS1Z5bTM1d0d2ckdMQldQbnJra1ZZWEZaMVJFRm82YzlmTU1waGg4d28z?=
 =?utf-8?B?bEk0MXZtTllZbWZURnhsN0xjQXNyUHJkY0hSeXVOZE9CWllYTU45akc2VUJB?=
 =?utf-8?B?d0dHRWs5VmZoc0x1eXBDVkFXNXVkeGFER1I0REFZKy94clA2U29TbzBDN0tE?=
 =?utf-8?B?UnY3dk0wVkpjQVFpczArM3U1OFFqdVFURWY2Y2U5Z3B4bERsVitxMm0wenBw?=
 =?utf-8?B?VnlDZ2JXa2I2cXUzd2VpclhNNlFNUkRpL1ZncWhCaHZhekhBcVJweTZqM1VD?=
 =?utf-8?B?ZkxoVzhTSjNkZVNaREpQQTFXTW1PbzNxWHJLY2JDaklpelczWjJQWDkvU0dC?=
 =?utf-8?B?Q1h1V3pYNmJPcTcrSndPTlNvdGFyajI5Tlk4WXI4K1RUY0N6dVQwQ2VzS2Mr?=
 =?utf-8?B?NGlvSDEzNFg2QnpCTDZuU0praFNVWk43UzJhYzd0VjBYZTJRZVpqK3pVRzlV?=
 =?utf-8?B?cWJwcWN6RVlUTVV6SGZCdFJJVGV0ZGY1a1BrVW1zeDB5NTJleVE3c0xxeXFZ?=
 =?utf-8?B?bGJHYzYzTUR4WmVkOWJPbWJhdCtielMrZGV4b2F2NExxbnVpbkZ4WFJ1S251?=
 =?utf-8?B?ZDVhMmwrM3lEems1OThtaFpYRHRWNHJNUjZ6R2czZ2wra0tYTzcvanNRUUNQ?=
 =?utf-8?B?YkpteGxueFdubzNUNzJQcVpud2xVS2dPOCtuS0VYSUpYVzNiUTRGMmt6dkll?=
 =?utf-8?B?ZnBzNDBQL0w5M3JjTUJ0UzFpSUwwaSt1Z3FiRENlOXFOSnFYTzhSSHNoUjNV?=
 =?utf-8?B?U2NZNWZ4dnYvQTBBOW1wZTYyd0tSTUwrODRHQXpWdTNTc1Rucm9EQmdXczh5?=
 =?utf-8?B?di91SndFUzYxVW5vNUY0THZEa1VNMGh1T2FJREZ2NVFKWlZ1ZEc5QlJjWURx?=
 =?utf-8?B?ZGhUdlEyaTJRN3ZrV2RKQ0lBUzV3Y3NRY2VKWko4U2xEUENncUxLRjhEd2d0?=
 =?utf-8?B?L2N2eURrbTE3c083aTNkeWswQVdQMlNLRUoxcWlIRVp6Z2U1RUNxamxwRmp1?=
 =?utf-8?B?L3cxS1NTTTJ0TmJIWjRvbzJ4NDA3VlZvOGU0OFpzYmlXV1J2ak5ibzJUSWdY?=
 =?utf-8?B?ODlTMW54K204RUp5WFFiUG0xVHRGUWlLZjY4eC9CMU56SlNTS2ppaFBsdktL?=
 =?utf-8?B?R0VXVTA4dVlsWWYzK0xyaTNkMUpJL3FQYnIwd1h0ZnR2NjZ2K2xWaXV0emhw?=
 =?utf-8?B?QWxJMENDL3lBdGdybm02NERPWVNSdFlLelpWcjI1VDFGRnVYM3k4VzVVVTJt?=
 =?utf-8?B?cEdxd0I0MC90R3UyTFRTOFNPaUs3RUdTTGNtWStwQ1ZlQU41dkdIMlJLWFRz?=
 =?utf-8?B?OUsraEg1Q1hKOUd4VjJxTXdZSll5N3MxYUkrUjFzYk16cUVZTEFJVjJzajll?=
 =?utf-8?B?eGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F308EB58239A8049B9A8B9154EE7F0CC@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7183.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ffb74c-3f62-4304-4df9-08dcb6d4eeef
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2024 11:34:43.7389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ek8Xrr094Fv/lyoOBpCYfyKqSRwZS33yboeP6Vcl7TKSFAvvyPFw9eq7Lc47HxZiXo+82zRRDnhlZ7zVkL/eFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8002

T24gVHVlLCAyMDI0LTA4LTA2IGF0IDE1OjQwIC0wNDAwLCBTdGV2ZW4gUm9zdGVkdCB3cm90ZToN
Cj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3Ig
dGhlIGNvbnRlbnQuDQo+ICBPbiBNb24sIDUgQXVnIDIwMjQgMTM6NTk6MjIgKzA4MDANCj4gVHpl
LW5hbiBXdSA8VHplLW5hbi5XdUBtZWRpYXRlay5jb20+IHdyb3RlOg0KPiANCj4gPiAidHJhY2lu
Z19tYXAtPm5leHRfZWx0IiBpbiBnZXRfZnJlZV9lbHQoKSBpcyBhdCByaXNrIG9mDQo+IG92ZXJm
bG93aW5nLg0KPiA+IA0KPiA+IE9uY2UgaXQgb3ZlcmZsb3dzLCBuZXcgZWxlbWVudHMgY2FuIHN0
aWxsIGJlIGluc2VydGVkIGludG8gdGhlDQo+IHRyYWNpbmdfbWFwDQo+ID4gZXZlbiB0aG91Z2gg
dGhlIG1heGltdW0gbnVtYmVyIG9mIGVsZW1lbnRzIChgbWF4X2VsdHNgKSBoYXMgYmVlbg0KPiBy
ZWFjaGVkLg0KPiA+IENvbnRpbnVpbmcgdG8gaW5zZXJ0IGVsZW1lbnRzIGFmdGVyIHRoZSBvdmVy
ZmxvdyBjb3VsZCByZXN1bHQgaW4NCj4gdGhlDQo+ID4gdHJhY2luZ19tYXAgY29udGFpbmluZyAi
dHJhY2luZ19tYXAtPm1heF9zaXplIiBlbGVtZW50cywgbGVhdmluZyBubw0KPiBlbXB0eQ0KPiA+
IGVudHJpZXMuDQo+ID4gSWYgYW55IGF0dGVtcHQgaXMgbWFkZSB0byBpbnNlcnQgYW4gZWxlbWVu
dCBpbnRvIGEgZnVsbCB0cmFjaW5nX21hcA0KPiB1c2luZw0KPiA+IGBfX3RyYWNpbmdfbWFwX2lu
c2VydCgpYCwgaXQgd2lsbCBjYXVzZSBhbiBpbmZpbml0ZSBsb29wIHdpdGgNCj4gcHJlZW1wdGlv
bg0KPiA+IGRpc2FibGVkLCBsZWFkaW5nIHRvIGEgQ1BVIGhhbmcgcHJvYmxlbS4NCj4gPiANCj4g
PiBGaXggdGhpcyBieSBwcmV2ZW50aW5nIGFueSBmdXJ0aGVyIGluY3JlbWVudHMgdG8gInRyYWNp
bmdfbWFwLQ0KPiA+bmV4dF9lbHQiDQo+ID4gb25jZSBpdCByZWFjaGVzICJ0cmFjaW5nX21hcC0+
bWF4X2VsdCIuDQo+ID4gDQo+ID4gQ28tZGV2ZWxvcGVkLWJ5OiBDaGVuZy1KdWkgV2FuZyA8Y2hl
bmctanVpLndhbmdAbWVkaWF0ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IENoZW5nLUp1aSBX
YW5nIDxjaGVuZy1qdWkud2FuZ0BtZWRpYXRlay5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogVHpl
LW5hbiBXdSA8VHplLW5hbi5XdUBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gV2UgaGF2ZSBl
bmNvdW50ZXJlZCB0aGlzIGlzc3VlIGludGVybmFsbHkgYWZ0ZXIgZW5hYmxpbmcgdGhlDQo+ID4g
dGhyb3R0bGVfcnNzX3N0YXQgZmVhdHVyZSBwcm92aWRlZCBieSBQZXJmZXR0byBpbiBiYWNrZ3Jv
dW5kIGZvcg0KPiBtb3JlIHRoYW4NCj4gPiB0d28gZGF5cywgZHVyaW5nIHdoaWNoIGByc3Nfc3Rh
dGAgdHJhY2Vwb2ludCB3YXMgaW52b2tlZCBvdmVyIDJeMzINCj4gdGltZXMuDQo+ID4gQWZ0ZXIg
dHJhY2luZ19tYXAtPm5leHRfZWx0IG92ZXJmbG93LCBuZXcgZWxlbWVudHMgY2FuIGNvbnRpbnVl
IHRvDQo+IGJlIA0KPiA+IGluc2VydGVkIHRvIHRoZSB0cmFjaW5nX21hcCBiZWxvbmcgdG8gYHJz
c19zdGF0YC4NCj4gPiBUaGVuIHRoZSBDUFUgY291bGQgaGFuZyBpbnNpZGUgdGhlIHdoaWxlIGRl
YWQgbG9vcCBpbiBmdW5jdGlvbg0KPiA+IGBfX3RyYWNpbmdfbWFwX2luc2VydCgpYCBieSBjYWxs
aW5nIGl0IGFmdGVyIHRoZSB0cmFjaW5nX21hcCBsZWZ0DQo+IG5vIGVtcHR5DQo+ID4gZW50cnku
DQo+ID4gDQo+ID4gQ2FsbCB0cmFjZSBkdXJpbmcgaGFuZzoNCj4gPiAgIF9fdHJhY2luZ19tYXBf
aW5zZXJ0KCkNCj4gPiAgIHRyYWNpbmdfbWFwX2luc2VydCgpDQo+ID4gICBldmVudF9oaXN0X3Ry
aWdnZXIoKQ0KPiA+ICAgZXZlbnRfdHJpZ2dlcnNfY2FsbCgpDQo+ID4gICBfX2V2ZW50X3RyaWdn
ZXJfdGVzdF9kaXNjYXJkKCkNCj4gPiAgIHRyYWNlX2V2ZW50X2J1ZmZlcl9jb21taXQoKQ0KPiA+
ICAgdHJhY2VfZXZlbnRfcmF3X2V2ZW50X3Jzc19zdGF0KCkNCj4gPiAgIF9fdHJhY2VpdGVyX3Jz
c19zdGF0KCkNCj4gPiAgIHRyYWNlX3Jzc19zdGF0KCkNCj4gPiAgIG1tX3RyYWNlX3Jzc19zdGF0
KCkNCj4gPiAgIGluY19tbV9jb3VudGVyKCkNCj4gPiAgIGRvX3N3YXBfcGFnZSgpDQo+ID4gDQo+
ID4gdGhyb3R0bGVfcnNzX3N0YXQgaXMgbGl0ZXJhbGx5IGEgc3ludGhldGljIGV2ZW50IHRyaWdn
ZXJlZCBieQ0KPiBgcnNzX3N0YXRgDQo+ID4gd2l0aCBjb25kaXRpb246DQo+ID4gIDEuICRlY2hv
ICJyc3Nfc3RhdF90aHJvdHRsZWQgdW5zaWduZWQgaW50IG1tX2lkIHVuc2lnbmVkIGludCBjdXJy
DQo+IGludA0KPiA+ICAgICBtZW1iZXIgbG9uZyBzaXplIiA+PiAvc3lzL2tlcm5lbC90cmFjaW5n
L3N5bnRoZXRpY19ldmVudHMNCj4gPiAgMi4gJGVjaG8NCj4gPiAgICAgJ2hpc3Q6a2V5cz1tbV9p
ZCxtZW1iZXI6YnVja2V0PXNpemUvMHg4MDAwMDpvbmNoYW5nZSgkYnVja2V0KS5yDQo+IHNzX3N0
YXRfDQo+ID4gICAgIHRocm90dGxlZChtbV9pZCxjdXJyLG1lbWJlcixzaXplKScgPg0KPiA+ICAg
ICAvc3lzL2tlcm5lbC90cmFjaW5nL2V2ZW50cy9rbWVtL3Jzc19zdGF0L3RyaWdnZXINCj4gPiAN
Cj4gPiBUaGUgaGFuZyBpc3N1ZSBjb3VsZCBhbHNvIGJlIHJlcHJvZHVjZWQgZWFzaWx5IGJ5IGNh
bGxpbmcgYQ0KPiBjdXN0b21pemUNCj4gPiB0cmFjZSBldmVudCBgbXlldmVudCh1NjQgbXljb3Vu
dClgIGZvciBtb3JlIHRoYW4gMl4zMisobWFwX3NpemUtDQo+IG1heF9lbHRzKQ0KPiA+IHRpbWVz
IGR1cmluZyBpdHMgaGlzdG9ncmFtIGVuYWJsZWQgd2l0aCB0aGUga2V5IHNldCB0byB2YXJpYWJs
ZQ0KPiAibXljb3VudCIuDQo+ID4gV2hpbGUgd2UgY2FsbCBgbXlldmVudGAgd2l0aCBkaWZmZXJl
bnQgYXJndW1lbnQgIm15Y291bnQiDQo+IGV2ZXJ5dGltZS4NCj4gPiANCj4gPiBCVFcsIEkgYWRk
ZWQgQ2hlbmctanVpIHRvIENvLWRldmVsb3BlZCBiZWNhdXNlIHdlIGhhdmUgYSBsb3Qgb2YNCj4g
ZGlzY3Vzc2lvbnMNCj4gPiBkdXJpbmcgZGVidWdnaW5nIHRoaXMuDQo+ID4gLS0tDQo+ID4gIGtl
cm5lbC90cmFjZS90cmFjaW5nX21hcC5jIHwgNiArKystLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEv
a2VybmVsL3RyYWNlL3RyYWNpbmdfbWFwLmMNCj4gYi9rZXJuZWwvdHJhY2UvdHJhY2luZ19tYXAu
Yw0KPiA+IGluZGV4IGE0ZGNmMGYyNDM1Mi4uM2E1NmU3YzhhYTRmIDEwMDY0NA0KPiA+IC0tLSBh
L2tlcm5lbC90cmFjZS90cmFjaW5nX21hcC5jDQo+ID4gKysrIGIva2VybmVsL3RyYWNlL3RyYWNp
bmdfbWFwLmMNCj4gPiBAQCAtNDU0LDcgKzQ1NCw3IEBAIHN0YXRpYyBzdHJ1Y3QgdHJhY2luZ19t
YXBfZWx0DQo+ICpnZXRfZnJlZV9lbHQoc3RydWN0IHRyYWNpbmdfbWFwICptYXApDQo+ID4gIHN0
cnVjdCB0cmFjaW5nX21hcF9lbHQgKmVsdCA9IE5VTEw7DQo+ID4gIGludCBpZHg7DQo+ID4gIA0K
PiA+IC1pZHggPSBhdG9taWNfaW5jX3JldHVybigmbWFwLT5uZXh0X2VsdCk7DQo+ID4gK2lkeCA9
IGF0b21pY19mZXRjaF9hZGRfdW5sZXNzKCZtYXAtPm5leHRfZWx0LCAxLCBtYXAtPm1heF9lbHRz
KTsNCj4gDQo+IEkgZ3Vlc3Mgd2UgbmVlZCB0byBhZGQgKHdpdGggYSBjb21tZW50KToNCj4gDQo+
IGlkeC0tOw0KPiANClRoYW5rcyBmb3IgcmV2aWV3aW5nIHRoaXMhDQoNCkJ5IHJlZmVyZW5jZSB0
byAiL2luY2x1ZGUvbGludXgvYXRvbWljL2F0b21pYy1pbnN0cnVtZW50ZWQuaCIsDQpgYXRvbWlj
X2ZldGNoX2FkZF91bmxlc3NgIHdpbGwgcmV0dXJuIHRoZSBvcmlnaW5hbCB2YWx1ZSBiZWZvcmUg
dGhlDQphZGRpbmcgaGFwcGVucyBvbiBvcGVyYW5kcy4NClRoZXJlZm9yZSwgdGhlIHJldHVybiB2
YWx1ZXMgb2YgYGF0b21pY19mZXRjaF9hZGRgLCB3aWxsIHNlcXVlbnRpYWxseQ0KYmU6DQogICAg
LSAwLCAxLCAyLCAuLi4sIG1heF9lbHRzLTEsIG1heF9lbHRzLCBtYXhfZWx0cywgbWF4X2VsdHMs
IC4uLiAoaW4NCnRoaXMgY2FzZSkNCg0KSSd2ZSBhbHNvIG9ic2VydmVkIHRoZSByZXN1bHQgZnJv
bSBteSBsb2NhbCB0ZXN0Lg0KQW5kIEkgZ3Vlc3MgdGhlIHJlc3VsdCBpcyBhbHJlYWR5IHdoYXQg
d2UgZGVzaXJlPyAoZWx0IHdpbGwgaW5zZXJ0IHRvDQptYXAgZnJvbSBpbmRleCAwKS4NCg0KSGVy
ZSdzIHRoZSBjb21tZW50IGZyb20gImF0b21pYy1pbnN0cnVtZW50ZWQuaCI6DQogIGF0b21pY19m
ZXRjaF9hZGRfdW5sZXNzKCkgLSBhdG9taWMgYWRkIHVubGVzcyB2YWx1ZSB3aXRoIGZ1bGwNCm9y
ZGVyaW5nDQogIEB2OiBwb2ludGVyIHRvIGF0b21pY190DQogIEBhOiBpbnQgdmFsdWUgdG8gYWRk
DQogIEB1OiBpbnQgdmFsdWUgdG8gY29tcGFyZSB3aXRoDQogIElmIChAdiAhPSBAdSksIGF0b21p
Y2FsbHkgdXBkYXRlcyBAdiB0byAoQHYgKyBAYSkgd2l0aCBmdWxsIG9yZGVyaW5nLg0KICBPdGhl
cndpc2UsIEB2IGlzIG5vdCBtb2RpZmllZCBhbmQgcmVsYXhlZCBvcmRlcmluZyBpcyBwcm92aWRl
ZC4NCiAgVW5zYWZlIHRvIHVzZSBpbiBub2luc3RyIGNvZGU7IHVzZSByYXdfYXRvbWljX2ZldGNo
X2FkZF91bmxlc3MoKQ0KdGhlcmUuDQogIFJldHVybjogVGhlIG9yaWdpbmFsIHZhbHVlIG9mIEB2
Lg0KDQpUaGFua3MNCi0tIFR6ZS1uYW4NCg0KPiA+ICBpZiAoaWR4IDwgbWFwLT5tYXhfZWx0cykg
ew0KPiANCj4gT3RoZXJ3aXNlIHRoZSBtYXggZWxlbWVudHMgd2lsbCBiZSBvZmYgYnkgb25lLg0K
PiANCj4gPiAgZWx0ID0gKihUUkFDSU5HX01BUF9FTFQobWFwLT5lbHRzLCBpZHgpKTsNCj4gDQo+
IEFuZCB0aGUgaW5kZXggd2lsbCBza2lwIHBvc2l0aW9uIHplcm8uDQo+IA0KPiAtLSBTdGV2ZQ0K
PiANCj4gPiAgaWYgKG1hcC0+b3BzICYmIG1hcC0+b3BzLT5lbHRfaW5pdCkNCj4gPiBAQCAtNjk5
LDcgKzY5OSw3IEBAIHZvaWQgdHJhY2luZ19tYXBfY2xlYXIoc3RydWN0IHRyYWNpbmdfbWFwICpt
YXApDQo+ID4gIHsNCj4gPiAgdW5zaWduZWQgaW50IGk7DQo+ID4gIA0KPiA+IC1hdG9taWNfc2V0
KCZtYXAtPm5leHRfZWx0LCAtMSk7DQo+ID4gK2F0b21pY19zZXQoJm1hcC0+bmV4dF9lbHQsIDAp
Ow0KPiA+ICBhdG9taWM2NF9zZXQoJm1hcC0+aGl0cywgMCk7DQo+ID4gIGF0b21pYzY0X3NldCgm
bWFwLT5kcm9wcywgMCk7DQo+ID4gIA0KPiA+IEBAIC03ODMsNyArNzgzLDcgQEAgc3RydWN0IHRy
YWNpbmdfbWFwICp0cmFjaW5nX21hcF9jcmVhdGUodW5zaWduZWQNCj4gaW50IG1hcF9iaXRzLA0K
PiA+ICANCj4gPiAgbWFwLT5tYXBfYml0cyA9IG1hcF9iaXRzOw0KPiA+ICBtYXAtPm1heF9lbHRz
ID0gKDEgPDwgbWFwX2JpdHMpOw0KPiA+IC1hdG9taWNfc2V0KCZtYXAtPm5leHRfZWx0LCAtMSk7
DQo+ID4gK2F0b21pY19zZXQoJm1hcC0+bmV4dF9lbHQsIDApOw0KPiA+ICANCj4gPiAgbWFwLT5t
YXBfc2l6ZSA9ICgxIDw8IChtYXBfYml0cyArIDEpKTsNCj4gPiAgbWFwLT5vcHMgPSBvcHM7DQo+
IA0K
