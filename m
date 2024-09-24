Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2070.outbound.protection.outlook.com [40.107.21.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E641712E1C2;
	Tue, 24 Sep 2024 07:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.70
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727162037; cv=fail; b=LjnfsISeaoZOUOa0He3HzJm927WURkp086shgbRfEcgFSBb/reADHugVYd2U60ItKeMtWla1sT6idp60WEarPiyFjfoOd8VUrZfMe2Nird+9yA9g6J7XMeMvK3LKUIOZ3JckcgaLaFeYTBMtEybTOBmYzRFVox9hpVofTVzqol0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727162037; c=relaxed/simple;
	bh=46/qEbgujKrKXJ1F/3hrXLev/NKueSjVJ0E6oWt3Fak=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SdktOGC8S+HujiSjniHaMiGdNYvsoUNditcSKIB/g4reuga0+Dzer1QKUakxdyC9dSOBPF3QvM1ZKATrKZIYRcZYKMRInbsJAwFLVWZP7yKWnzF99akPaLlzcDtsVUDKMKL9wBIYZDpEamnd4rNxemizqDt9WT5GMUcIai+jBIU=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Z6ORepQ6; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Z6ORepQ6; arc=fail smtp.client-ip=40.107.21.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Z6ORepQ6";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Z6ORepQ6"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=gMYPtUnMZ4NSCTYza2kUah0m4divnW+fmmIGHbswm1zzyNhIzPyfchmLqXK2RTJI2NPhR1cbfxd6P/suM2WqTTY23f9YPfcgcu2pkywiZixaCEYRSqlK7XWLv9p6vBxs6rPLLt1U6NjpfO5CW8Y+y2iBotGgT47exgQsPPNK35Lu7g5xI79tTB/DxrIdV5HKQ5CGxpqaveKMeYtsPN3+Woo4YDXXMJPHh44Dy7S/UJLaA+2tNIl28bVZ3peaxU9XN/tNSvspVoGhUaUJYRENUUn89oWxsvWEs45c10P5DOt0aHsGDryfCOwRpQ3FL1xEqXxU+ghT6KH5cYCpH7u98A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NKRlkzQfXqIYD8UzeEeaK0+3Qf29iKVEaGN5VDY711g=;
 b=Qz8SAaG7KN+RX0+WmdzBxZ5HFQSLZ2ANZWV2ZxTilXlzqiXpf7KXGlmcZcBgIE1SFPMnX/G7LTkUcqAZvLBiOz14iAiJhcxJ24lFqyWmsHsJDr3uwgwuF+9RfsE4zetR3In+XsJjjEP9xc1mEMep/fab7ryP9Qx1NdS2AJnhhE+m7CTyOTZdW3Kx9cgJ4uK6LBQ2G1krKcuwFm5HUxfdn7WELwjNZTtPikqBt0W2IK3+ny8Ej06ZjV3RZ6ZNt16DSjcJ5juO2eXUgZk0A0cs6SPHfVFPRwQiU2kkkGd1vbHe+7HNWf9P9OGW7CunSMyhurZlvmeU7+5mPcqmsss3wA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKRlkzQfXqIYD8UzeEeaK0+3Qf29iKVEaGN5VDY711g=;
 b=Z6ORepQ6cwSGZJKOBBr5OJSb/OB5nNv6wni46YjIFYxBIkT1ZHsCYKILnF1jhD87I0JJH02c7/cGLIBsbtCA4kKJ7h+NNrp6FeszCGvywPk2hc59+VSZ8VKhGPUk5qrl+aph2Sv8UPCFvAMOkCBLRB+OTOIhqXPFvsSpM5tjc6w=
Received: from AS9PR06CA0304.eurprd06.prod.outlook.com (2603:10a6:20b:45b::30)
 by AS8PR08MB6437.eurprd08.prod.outlook.com (2603:10a6:20b:33b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.13; Tue, 24 Sep
 2024 07:13:46 +0000
Received: from AMS0EPF00000197.eurprd05.prod.outlook.com
 (2603:10a6:20b:45b:cafe::c8) by AS9PR06CA0304.outlook.office365.com
 (2603:10a6:20b:45b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25 via Frontend
 Transport; Tue, 24 Sep 2024 07:13:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS0EPF00000197.mail.protection.outlook.com (10.167.16.219) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7918.13
 via Frontend Transport; Tue, 24 Sep 2024 07:13:45 +0000
Received: ("Tessian outbound 245dacdadcd4:v465"); Tue, 24 Sep 2024 07:13:45 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: b386bed82cad9192
X-TessianGatewayMetadata: aB9mnle0PhG253LTbCEHuQi8Pvk/H3+OKxhPPhtUXYqhBeq8QjNXOaTkGGZWmss7L+UOSADtDJimFcEKG0JyClLhMNeiaj+L/XIV64e7+OPRdSHg9U65CscZMd0Bw6mNIOwuPf5qJJmpgVH58Ofbwx6crpvNUwuVnJxzGLveX1zD9xA8a17umiDFgwh40ahLcXBe7UXbmUGP2iybeXwy7Q==
X-CR-MTA-TID: 64aa7808
Received: from L78340b734a49.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 6FEDDD98-973C-4E1E-89B5-203680C8F425.1;
	Tue, 24 Sep 2024 07:13:34 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L78340b734a49.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 24 Sep 2024 07:13:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GMxVsCTQrPtIy4Gc4jHPm1hKnPT7DHr2nzfyXBMCHccwjVCKQ0t+39DkSqeUEkF1OwJZQZ0Ii4x8zX1KDsq/gU76oyWYjbGn/zFhtbjDxd6Kkel4qXJgmV1VJTgyVAXJ7VxlA/3paI4VUPar9sbEZ8O/OJl2ZBq3SlUXdHEwDYU1yi87FIoNNVG1/8uOk/W3+uhxSxDG/6DjT9hKln2YE2zcsmg+970wHrCRPOc7lxbDtbdlFoAwlNManP0ULE5T8RGwkrWIMdaZPqeh8CPsVWsSR+7J1UAZk2wwIZ+dSiH+CStgneOO+W+ikEnAJpz4L0TSR4urgZyqS6Rw4wV6Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NKRlkzQfXqIYD8UzeEeaK0+3Qf29iKVEaGN5VDY711g=;
 b=dZGV3OItrcshWKR+9zwhbPkmEvrBlI/+exf4Tbw9rLEUs1WQ0LRl75bnmbhjECYkqdwltzK3d6bVd+Up9pZg6dTWaB5KOTOrb8I9KuJK/ReNKj24X7zwETd7R2DxaiNe8CeaaeQW+5FhfJhrkJVD7hNfmRNToUDfgq+qHtmDd5SOzBSf75aYkRn6HysjNh2YCru+GPw+0BwmEufhpAT1aJwzZaXHb3oeLoFpkYFJnmzb8cu4NtR81bJRqL7lQp4O58OF+LuoWLbRX5bqy9uyUg6rn+eYo+Z5iqnDvMtBnXB3VCQrpxPvpnhfiPgSh64wqDyYuGv7SQR+h8h1GCBIBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKRlkzQfXqIYD8UzeEeaK0+3Qf29iKVEaGN5VDY711g=;
 b=Z6ORepQ6cwSGZJKOBBr5OJSb/OB5nNv6wni46YjIFYxBIkT1ZHsCYKILnF1jhD87I0JJH02c7/cGLIBsbtCA4kKJ7h+NNrp6FeszCGvywPk2hc59+VSZ8VKhGPUk5qrl+aph2Sv8UPCFvAMOkCBLRB+OTOIhqXPFvsSpM5tjc6w=
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AM9PR08MB6017.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dc::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.13; Tue, 24 Sep
 2024 07:13:31 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%3]) with mapi id 15.20.8005.010; Tue, 24 Sep 2024
 07:13:31 +0000
From: Yeo Reum Yun <YeoReum.Yun@arm.com>
To: "rostedt@goodmis.org" <rostedt@goodmis.org>, "mhiramat@kernel.org"
	<mhiramat@kernel.org>, "mathieu.desnoyers@efficios.com"
	<mathieu.desnoyers@efficios.com>, "a.p.zijlstra@chello.nl"
	<a.p.zijlstra@chello.nl>, "mingo@elte.hu" <mingo@elte.hu>, Mark Rutland
	<Mark.Rutland@arm.com>, "james.clark@linaro.org" <james.clark@linaro.org>
CC: nd <nd@arm.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] trace/trace_event_perf: remove duplicate samples on
 the first tracepoint event
Thread-Topic: [PATCH v2] trace/trace_event_perf: remove duplicate samples on
 the first tracepoint event
Thread-Index: AQHbBYKXoi2hw6C5d0ic7zmh6yP4AbJml3nt
Date: Tue, 24 Sep 2024 07:13:31 +0000
Message-ID:
 <GV1PR08MB105212F94288290E4DD6602DFFB682@GV1PR08MB10521.eurprd08.prod.outlook.com>
References: <20240913021347.595330-1-yeoreum.yun@arm.com>
In-Reply-To: <20240913021347.595330-1-yeoreum.yun@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	GV1PR08MB10521:EE_|AM9PR08MB6017:EE_|AMS0EPF00000197:EE_|AS8PR08MB6437:EE_
X-MS-Office365-Filtering-Correlation-Id: 03730fc2-49aa-4edd-9d9e-08dcdc686df7
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?j306BTNasz7XG712BRj1YQGFCqy3nJgaY1iuNiiVd+y1ZqxYPS64OyUsm9O1?=
 =?us-ascii?Q?bl8tuZrIx1vbZ5eB95ETqCUFIsjo5bbhYLW6/QwgPclF41hEdW1ZXkjJ1RvA?=
 =?us-ascii?Q?cwJiICXM0kRXQHiLem5cWQ1R5DpnuydBwEtezVVFXOinL1d42qiusGbBH5N1?=
 =?us-ascii?Q?wSw8O7f70/da/CQyouQDJp8Drqv4npKACmMlSi8HsbFnGCyV3efrS+DmuzfH?=
 =?us-ascii?Q?zMoz6fOCEGt23XVR9KV2i3aYP3WGeE+3rrl7Wij45q3tBexH2lpOGR8lpehk?=
 =?us-ascii?Q?2yHGsYcF0esGqjDgrFEOWrOg5UAb3zicdqOvgxHHEJ9jCoy8cwOXymffeHrW?=
 =?us-ascii?Q?Du9urqsbYjJgbeJvyLdKwvMZU3leJDfeGMOhqFyQs6H4aX1ZEIlc7hW1jTRr?=
 =?us-ascii?Q?Jjbo+bHkAMxqNUwn0nEhHA3TQFZNh3CefiWXMeJsg3aFKLCAH7FNd+c6Pg7s?=
 =?us-ascii?Q?XqYYKbIYB5hooVwe4yURA6M6yKlahVin7V9A3tFiUJbuF5yxqK9YAYeNaqGn?=
 =?us-ascii?Q?HYXBbvFchEtN2lIQBknYDX8dEjRM9BY3iDJPYOL6PxvcfDiOkNYzwO5/FDqE?=
 =?us-ascii?Q?e+uW0VY6iTUFMAVgmEHsUWmDNnmoOX/PEvt5a05p6XdoJ7QQXvgwK5lRkLwH?=
 =?us-ascii?Q?VlJoUzNGpxctNGw3uvCGHjyaQY15s3HKTaI4ry/bVDoNnqO0SmE6K2KSAIhG?=
 =?us-ascii?Q?n4vv7ojwK+dV4uFBBGGXgiiomMndVI+kqjCY3kxydx8U9b7yQ/hf61f6scRB?=
 =?us-ascii?Q?AeS4xdcgxzmtRnd6RFfBQVLiLKIxrK0AvtSRBOvjwDGeRGSjWk0ag3yGWFXI?=
 =?us-ascii?Q?HVXQF7kQZ23MuaG+TkCFIMAh8Z9qywCDwKlpHiBkmIKgxj8eQ/P3rjJ2lQvF?=
 =?us-ascii?Q?G5KR/dcvSuiIrZKTLNLQWJuLpqTwBmdqdGsYSXfWEJ+29HcAlXbnsy5TJiLc?=
 =?us-ascii?Q?jAQ5QfyhMsglSjo6R3aY3RojX/ba1s9Cp2a4XgGMPjLwBNxzdIQVdpjvRHnC?=
 =?us-ascii?Q?cysW+jCe8XGJXimyWneKVdLZRXBSkzJ5ioZHGkXfPw1veL3JFILMNWZoSxtJ?=
 =?us-ascii?Q?rzD/4fl/RDxDMezJZHyPNsfflr1ClhDnctclb8YnzbjV1dcMXLNAb++5/M03?=
 =?us-ascii?Q?h4P2Ey2o5hO02aE/RFwc4GdT4Kwl8sWy4cI+Cl5dRndvUAA7K7FQbm8Faqb0?=
 =?us-ascii?Q?5ug1N77mNpYzDegdTWUZb5p22j63S/ITdeh/3YQs5uCFibiBEK3qziZ+Jp15?=
 =?us-ascii?Q?GqNOH/t/fiBdNYurmb7ve+LBL2yCKPO2nV7srYQuOFmXKASWzHZ0DbZv8Ama?=
 =?us-ascii?Q?1ft6MhKJEzJW9Tlks7C83qBRVARyhPlGq7xofFeCc0/NrPX5LNE1Wd3XTcZD?=
 =?us-ascii?Q?fSHwbJo5XksmtL01zgFsooLYGONxEg3U4D0ioAHjZmHgx8eaEg=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6017
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:163::20];domain=GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF00000197.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	c620adf6-375f-4254-323d-08dcdc686537
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nEok2lgoEiXwZ58A06RgPMTGPltmhB0VQq7r+Y6q05pteimtPCwcjoyqw2Fa?=
 =?us-ascii?Q?EFG4t7Y/5cYYcBVNSP0WOSvCJm4Sdda14IQ7RNBwNEl6RRNIWQYNr0LC+jKn?=
 =?us-ascii?Q?FG6CXdeq0ZgmMu2N8XpZf3ZdKdip0XGuTcNdWvHjlEdNqv2NlKJJFWgb7A76?=
 =?us-ascii?Q?ZJOTUhmgCksoxniVyxjYrr8npx/gCdoDNv/jpAtGCX+E+7p30edxCsTYVQAp?=
 =?us-ascii?Q?vBPOzSbuiDeZW0sK8YVhiFVHQyEWZmBTqF8mfKu2wC6LAUuAJMg35yPbHdiI?=
 =?us-ascii?Q?rmQkt3yebjpfdGIM9V6lMldyNpkiiKzLXelil+94AUywFJlah9zTTVXZOXed?=
 =?us-ascii?Q?ocHj3r534HZNnNgxza4E+J7GX17fIbxcp9Ova302uuoxaJLzK4ARpg+193dU?=
 =?us-ascii?Q?Su1O1wUGMQ7caZja19BUYG0w0xPJn563UKitxjxi1TJaqJj3ML5+bQ5ASg0g?=
 =?us-ascii?Q?S5gZzwHkTkVPexmpHCG8mcyTxTlYuTB8BSXCk5ZGLCO2bCwsl7d3SF6Aofnm?=
 =?us-ascii?Q?B8R1OQ4ZEk7H0Mvp1Ea4ML8XJEuhjOxK1v1VFSmjhBTxZcFFzGJbc48eF05N?=
 =?us-ascii?Q?6HBMDXtez6gOKPp2hC5shDhXMYJGpP99kGna6lmucFjsf8/3HhFEeBq6obn7?=
 =?us-ascii?Q?FOUrXFt2Hzb7Q1f5crDFZh5IHPXlO1bAPfiIoSZT1b0HE9s1xm9XrWvFwGzq?=
 =?us-ascii?Q?mSq6gTCpaRYpy9Z7dhg7hcj1c7Ug5zfj2UduVaEL+i76hROjg5faTJhx/wXj?=
 =?us-ascii?Q?eLQxO17Oqtbm3j50CSGITg7OCX1z16E/mq4kYhPd3D5KXiu5RmGJqhrUlY+H?=
 =?us-ascii?Q?z/wP8F1Cj4AxFYqe1ApG/i1VYNcA3TxFeZMdCjBlp8MVyZ90MAqbcTJtZLfB?=
 =?us-ascii?Q?mKwTlQ6FKFlvdZRVnFUYY0rCX6AMAD8Oh7Z/i1obLlXbKBzahX5Np3XdhUn2?=
 =?us-ascii?Q?LEyIL1Z6GeregZVEhXBLfEKTH7QIby0Ag7QaNpqQB7pn4VlbVSmZgkPODIhy?=
 =?us-ascii?Q?6qxywAGH+XlB258wZQwOCJ84s3dmY+R+gng78tOtqgCTtiIFlaLuDDBk1Ywz?=
 =?us-ascii?Q?e/haM0Oaed+jmeWDbsM9P+0SMOZJFyJkUd9yp84dhWP17PQ28chitGy7wNEM?=
 =?us-ascii?Q?jru3EL6Y5lx/tfrEfpjOeJi/2SDODMQdMfFqp+ecjKXXSbHIfBFSFPmYzyQl?=
 =?us-ascii?Q?JbKf1Paw2dOuheJDzP55Pg8CHhjl+mTto2HyONntln7V0L8G6UNu6jbnC9nn?=
 =?us-ascii?Q?uQi1JlA6eohWGe7mxWhTxvGoz1OmJYlYjxvV4S40t+z86gv9uhRSRgfaDvo1?=
 =?us-ascii?Q?dr91lJhOciiy2jtTCtw9LEyk08Vnz2/i1KYJySJdDgK+bUpMCSjicdK/EQZ+?=
 =?us-ascii?Q?G6hkoVCFO9zrIr6zEOVOGo1rMvfY?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 07:13:45.8640
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03730fc2-49aa-4edd-9d9e-08dcdc686df7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000197.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6437

Gentle ping

________________________________________
From: Levi Yun <yeoreum.yun@arm.com>
Sent: 13 September 2024 03:13
To: rostedt@goodmis.org; mhiramat@kernel.org; mathieu.desnoyers@efficios.co=
m; a.p.zijlstra@chello.nl; mingo@elte.hu; Mark Rutland; james.clark@linaro.=
org
Cc: nd; linux-kernel@vger.kernel.org; linux-trace-kernel@vger.kernel.org; Y=
eo Reum Yun
Subject: [PATCH v2] trace/trace_event_perf: remove duplicate samples on the=
 first tracepoint event

When a tracepoint event is created with attr.freq =3D 1,
'hwc->period_left' is not initialized correctly. As a result,
in the perf_swevent_overflow() function, when the first time the event occu=
rs,
it calculates the event overflow and the perf_swevent_set_period() returns =
3,
this leads to the event are recorded for three duplicate times.

Step to reproduce:
    1. Enable the tracepoint event & starting tracing
         $ echo 1 > /sys/kernel/tracing/events/module/module_free
         $ echo 1 > /sys/kernel/tracing/tracing_on

    2. Record with perf
         $ perf record -a --strict-freq -F 1 -e "module:module_free"

    3. Trigger module_free event.
         $ modprobe -i sunrpc
         $ modprobe -r sunrpc

Result:
     - Trace pipe result:
         $ cat trace_pipe
         modprobe-174509  [003] .....  6504.868896: module_free: sunrpc

     - perf sample:
         modprobe  174509 [003]  6504.868980: module:module_free: sunrpc
         modprobe  174509 [003]  6504.868980: module:module_free: sunrpc
         modprobe  174509 [003]  6504.868980: module:module_free: sunrpc

By setting period_left via perf_swevent_set_period() as other sw_event did,
This problem could be solved.

After patch:
     - Trace pipe result:
         $ cat trace_pipe
         modprobe 1153096 [068] 613468.867774: module:module_free: xfs

     - perf sample
         modprobe 1153096 [068] 613468.867794: module:module_free: xfs

Fixes: bd2b5b12849a ("perf_counter: More aggressive frequency adjustment")
Signed-off-by: Levi Yun <yeoreum.yun@arm.com>
---
Changes in v2:
  - Fix build error.
---
 kernel/trace/trace_event_perf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_per=
f.c
index 05e791241812..3ff9caa4a71b 100644
--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -352,10 +352,16 @@ void perf_uprobe_destroy(struct perf_event *p_event)
 int perf_trace_add(struct perf_event *p_event, int flags)
 {
        struct trace_event_call *tp_event =3D p_event->tp_event;
+       struct hw_perf_event *hwc =3D &p_event->hw;

        if (!(flags & PERF_EF_START))
                p_event->hw.state =3D PERF_HES_STOPPED;

+       if (is_sampling_event(p_event)) {
+               hwc->last_period =3D hwc->sample_period;
+               perf_swevent_set_period(p_event);
+       }
+
        /*
         * If TRACE_REG_PERF_ADD returns false; no custom action was perfor=
med
         * and we need to take the default action of enqueueing our event o=
n
--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

