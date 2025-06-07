Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013020.outbound.protection.outlook.com [40.107.159.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F62156CA;
	Sat,  7 Jun 2025 14:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.20
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749307395; cv=fail; b=FLarFXiNvR0nsu8UPjUqktPtm+zJ2BJ6V6/ooo9mcsg3xxjJso7xVwAbqWjyglBNPtbDM6/ZJGa1Y73q91DlvxslDjSTqz6LE9mNlHN6P65L0LsVArMSuZbLkB5ZVI0BERnGWnwKj7MtIfxYs5pN5aKsvw11gFl7ldwEI/33ahs=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749307395; c=relaxed/simple;
	bh=ZT23YWXSUo8Niy31QojZqzZOyYBsdI9yspWr5IrBcJ0=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ykm20LZnlxuZTuWq+yUShJXa2fqvYNYsZemHRJmHLLGkQ2HmQRuQAdtL+0s6pThJLuUF123orSuB0SE3lpLLMuc/yYG2sLmsbHJyNJkmxFYOXrsB3O7amF1FJi4aTvRryLHxASdjC9A0qWRIMATpaMfPXS8Vh00+KFzhxk6gaBM=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=L5ltwWNi; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=L5ltwWNi; arc=fail smtp.client-ip=40.107.159.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="L5ltwWNi";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="L5ltwWNi"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=eO849nYWNFfzJUdPeWy5cyXEjxmYzpmyZ9eQcMBeGXGnLZyef3wz9L/MqPJIa4Z6x+bxbR6zWHuAkc3xHNW7UDWtscqJHlD1WZ46FXVamAUKxl+xFo8zxMLTfO5zfh0AYbsmfuSShKGFcJOVggD05eVYkB4Td/cEya/MOlKqUm/Bdhx/UtHEjpCyPtmCMgrCLEUOwyDnmdbvTa+l6sxK4I/xlQKoS/NyicTIp+cet2hnjXeN7LsVgzGJBTRin2Cc4++w6lj2OxNUSVbpp3hs83RgDuybV2VCbmV6Ct2TvZrOa6sAD7m3BjRP++epZoMy6uvADetiEJhmzeYTi91gdw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LOGanH3DM9GlbMg+rNs+0T+KYf08qFgHj4V0wcAv+Hw=;
 b=mW6fYN/y8C+tsUjqBkWdTQNDYuK4LmvAEgtvHMe6SqbTac5WHAI83ekQPlSVXecnesVGSG5Wp0OwAKzRGc2XKd7Ei54OMZg/j0f3RjVcaCYwUmiYBomXEZgC6IaEXqTRiKj8Dn7bZfyFvYjYnTz5eSb/dVj4sQQ8TRrU3KZF1OaISp+2i35xlVEdORji9unRMb+NJ9ek0dmhg801yNCDa+V0rOVdU16BAiSNx5WbffoaWVTHz6g0ndupamiy0WAuoLYt1orK7mo7ug16tQWA2yDtp7YUcWYhooaxnClY+6nwrKRUSboBroDNQLsg0SXEmbaI0QxenoB/5OF0C4r+hA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=redhat.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LOGanH3DM9GlbMg+rNs+0T+KYf08qFgHj4V0wcAv+Hw=;
 b=L5ltwWNiD4etUj1Mkcze7YCEmkEg4BG1UcF3Wg2iE+KJ5WO3cJERWOx4ES9xwmlqsTclJ1EWhsV+yGLe4EIBf2ue3AIBeoKd8I7uYFn8jsXjKdgBtNdibKYqaKRhKr7W1xa02YAoBQ/sKf2kFlc0LPO36JAptnlYox34FtcA7Xs=
Received: from AM0PR04CA0057.eurprd04.prod.outlook.com (2603:10a6:208:1::34)
 by AM9PR08MB6164.eurprd08.prod.outlook.com (2603:10a6:20b:287::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Sat, 7 Jun
 2025 14:43:08 +0000
Received: from AM3PEPF0000A78D.eurprd04.prod.outlook.com
 (2603:10a6:208:1:cafe::d0) by AM0PR04CA0057.outlook.office365.com
 (2603:10a6:208:1::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.27 via Frontend Transport; Sat,
 7 Jun 2025 14:43:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF0000A78D.mail.protection.outlook.com (10.167.16.116) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.15
 via Frontend Transport; Sat, 7 Jun 2025 14:43:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hyEvAnVjBiiIxSZaFkn/I/PXScub5Q0UE/JCTHm+8ZvHd2EAHpcgTIBhT8S9aLUgCBX9h0KZiBNZKbN+17iWgpxXxUF3oPetcjy3JldEPLcVvOfl67RQmi+Uj2+VMak0P+JCC8NU5BUFlBxTpmqlZn26To7EQ0CG8pMMuLie0EyVK0lNz1ovIUJvagIXdzbaGyK5+AVkaQ8udkOuupqYZUvciqxEakhbv3BMKfXzwHi6cOjOgSDn+Kg1IFpgBkclJvWmYrXl0OfXaZD1CZMtrR4lusszTWwL6y7U08WaIXv+axwKoz2Scq4nbAz0uEpW3MNhS7Ov85diAiVvKuZm7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LOGanH3DM9GlbMg+rNs+0T+KYf08qFgHj4V0wcAv+Hw=;
 b=sUJ5tNHetN2R4/88Poq1SvPGphznNoQ2A1RVtAOmVTkbz7x3tIN9oDY3byCsYqSOd4fWycoF3TYhVz9gkTZzYJ9SnX0lWRYMpslS/V6VjIJQO8E0l8nzllJSFl0Axv3P7gneS5BKeYObGyhROYZ7fuOQcWeWfpO6DD3ACNMejjfNcrE+O+D1VMokQjUxE/IMpQsywACrGXDIsb3+ffa5hHc+Tn1MLatxKlJ5l44No+jpMxg+jDAWnttt0UYEIBGHceHTJ7A7NUZVNUZxvlJTnwNu4dU/RIOXdB9Jw9rSm4c+HxHVHT4Vyg1qyW7gt7lLQ9RmvHHzIatXyqKX3jWfIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LOGanH3DM9GlbMg+rNs+0T+KYf08qFgHj4V0wcAv+Hw=;
 b=L5ltwWNiD4etUj1Mkcze7YCEmkEg4BG1UcF3Wg2iE+KJ5WO3cJERWOx4ES9xwmlqsTclJ1EWhsV+yGLe4EIBf2ue3AIBeoKd8I7uYFn8jsXjKdgBtNdibKYqaKRhKr7W1xa02YAoBQ/sKf2kFlc0LPO36JAptnlYox34FtcA7Xs=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by DB9PR08MB9538.eurprd08.prod.outlook.com (2603:10a6:10:452::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.25; Sat, 7 Jun
 2025 14:42:34 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%2]) with mapi id 15.20.8813.024; Sat, 7 Jun 2025
 14:42:34 +0000
Message-ID: <1ae94fa5-8d68-4e4f-83e2-dfeefaab253a@arm.com>
Date: Sat, 7 Jun 2025 20:12:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/12] khugepaged: add mTHP support
From: Dev Jain <dev.jain@arm.com>
To: Nico Pache <npache@redhat.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com,
 corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
 baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
 wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com,
 vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com,
 yang@os.amperecomputing.com, kirill.shutemov@linux.intel.com,
 aarcange@redhat.com, raquini@redhat.com, anshuman.khandual@arm.com,
 catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org,
 dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org
References: <20250515032226.128900-1-npache@redhat.com>
 <20250515032226.128900-8-npache@redhat.com>
 <6f061c65-f3aa-42bb-ab70-b45afdcf2baf@arm.com>
 <CAA1CXcDVMdzNWS3maQPd3L2ZTOjnNyswH21H-BNfZpUPXk6UcQ@mail.gmail.com>
 <2666b1a8-12c0-475e-9aad-2fdc3e846e9a@arm.com>
Content-Language: en-US
In-Reply-To: <2666b1a8-12c0-475e-9aad-2fdc3e846e9a@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0P287CA0001.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::6) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|DB9PR08MB9538:EE_|AM3PEPF0000A78D:EE_|AM9PR08MB6164:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d47498b-beb3-4bb3-0d8c-08dda5d19e9a
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?RW9SUnVxVVlUYXlpTlhvNFdETSs3Q1RhR1ZVcmlmejBXbXZUTWFyY1B1SWRU?=
 =?utf-8?B?cDdyQjI0VGpScUtsYjhYSE4yMm5xMUUxbG90RGxybFZEaFlXcFd3eXdxUEpV?=
 =?utf-8?B?K2dXWVFiQ1c0SnpMUTdqYURReFFYMEEvbXBBbVlVOS85Q0w4WEk4N3hZbnJR?=
 =?utf-8?B?dGtFdEhKdDRFNlB3MVpZdW1PajY5SGZlcUwycS9GeDRJeUtmWVY0VXJyN2pK?=
 =?utf-8?B?QlNHSDc4blR0WmQxTXNrbGRnMnlNaG5zTndWcm9NdnZMT1diREQ5SVgvRUJT?=
 =?utf-8?B?eXNoVlIwMzhnZTBCRjRNazNjQUpXRWI4MDlsN2orVnNqYjBOZFkvT0NjRGFR?=
 =?utf-8?B?aVZkRCs4cFVGMWpSay9VS3JvWTFYMFAxNWJMZ255dXBoNEowN1Q3OHhEMnRt?=
 =?utf-8?B?RitpdE92MnE1OG1IOTlQS3RncXc0bGxrYVlkRUJ4VzFRNGRsQ3BXdUZlWGxN?=
 =?utf-8?B?NGpDbFFwSUFwdisyQXNxSWhQR1JjS2Z2cW0vOVMrVFROcnZickE5S2didmR6?=
 =?utf-8?B?NXBlUjMvZXUvbFM3c2ZEQmg4UTBsSnBzWnVDWnlORTRtZmVwYmNKcFlKWHcy?=
 =?utf-8?B?QXg4SW8zWkJZTTRteERDVU9xcWNpQVZpbjdGK1kwMGpsREZMUGdJb0hkY2Nm?=
 =?utf-8?B?Q1R6SzdVdTNDaDVHNlF4emdKRUFIaVRLSElmMnhiTmJjdHpQOEpSMmNIQnNO?=
 =?utf-8?B?NEhGTDVySWpjVXI0OXZ1emZPbTBUR2Z0MXl5M1NON205RTc3aGp5SGlmV09q?=
 =?utf-8?B?TC9ycVcyZDFheDJ4ZFhFMUVuVGtuUnlid0FHSzNYVmlhb0dhNjE4cFJiNjBq?=
 =?utf-8?B?b0tZM252T0JSMTJac01KT2FYYmhMWk03Y0ZTekRwUUltR3VPL001K3QxbFY5?=
 =?utf-8?B?Y2R4T3NuQWJVOUhpTUZoSFluRTVCQzBKMVYwbkNNV3hFanRMazlSREF3L3pa?=
 =?utf-8?B?ejhuUWxMSmJxUXpyS1VaVFZyVTk1ZlhGQktpRnpNUjdwTjhRaXRnZUUwRVhJ?=
 =?utf-8?B?TWR1cHpaYkVlSjlvVk9Ha2Fhbmh6SkllRjBDU2ljdlhEUTkrQUE1VDk1WHNu?=
 =?utf-8?B?MGYwcDkyaWZMdXMzdFVUb3czNHRzeFhud3RBT0ZjRVdCVklRKzloaXFHaDZ5?=
 =?utf-8?B?aWY3aitjZ0dqQ1BjTXg1SEN0R01uakhxWWFVVFFZT01sSGZ0U3RuZzk4OXpO?=
 =?utf-8?B?bm9iSzJUaFp3K0dnR2ZEOGNKZk5tZUhDK1dLUVRramwxL1c2QUhIcDFrckNE?=
 =?utf-8?B?ckhKeDlyNmRxU05HK09UY0hoc1dORmtuN1ZhbGtBTmN1dFpBNkltYXlrL2lJ?=
 =?utf-8?B?TU5FSVpsQjQwNSs1dVh4eDVqS25LOSttSCthWkc0cnMrZGV5MVFybXVtbDho?=
 =?utf-8?B?TjJHYUVpRVcvM2ZEVXQrOEZqdjVZZmFoU1ZwbU1CaXIwZndTTWlSbXNPL1U4?=
 =?utf-8?B?TFA1MzREMFF2bG9jTzYyMnFQSW9pTGxvZW95ZTVabVBnckdWM20xNEFWbEFw?=
 =?utf-8?B?ZW4vVkYzdmtwYXB3SEwrSDZuNWZUU2FlN2J1L01pZzJxTkdGSEV4ek5wK242?=
 =?utf-8?B?RURReTJCcGVGbU9QSlpMZnpqeFhTaEtmVUUvY3hkN3c4WFI3SENuRFNKTlpp?=
 =?utf-8?B?a0Y1eFVOTHR5d0dPMEVwSzNzNVZ1blB6MWJHRG1CR0lWQnBhY3FENWFLcHMy?=
 =?utf-8?B?MDBJWlJvd05NL2EvL2ZUQlZRYmdiR1l1NU1odVdyazd1d29KMVlnM0JGa2xZ?=
 =?utf-8?B?ZzV2Q1E1YmQ3VlBGQ3pFQ0wrb0p4YWM5VjFHN2Rja1kzVThvTXRySEpBM0xY?=
 =?utf-8?B?TWZkcXp0aFJFZElxR0VtVUh6R3N6VmMwcEZNMEdiT2k3RkszYmQrRXlVeUhQ?=
 =?utf-8?B?OWg4d3F0RVVIZXpicjA1YUdVRUZ2UkQ0dTEyNGt2K0cyYWo4SVZPMHJZbEdt?=
 =?utf-8?Q?mJa91fiFDug=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9538
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF0000A78D.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	85766c16-7e4a-451f-08de-08dda5d18a30
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|82310400026|1800799024|376014|7416014|36860700013|14060799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RHd2THlsN3VjYlVQM2N4QTh6cVhleWV1QXc4WklIN2dlb3hnVS95U0N4NlNT?=
 =?utf-8?B?Zk1BeFBDenF4cjR2TEs5czloRVVVZlVUU051Z21haHozZW50L010ekZDaE1C?=
 =?utf-8?B?UDJZc01vbnBObHJLamlQTG9iWUloNGJWYkp4UFpDQTJ4RFFkeGEydC9USTZn?=
 =?utf-8?B?YVYyRDVSRW1uVDEwcnNid2ZoaVRQZzhRN1NMLzJza2FhYlRoVXRvcmN6VzNm?=
 =?utf-8?B?UEtxVVBlYm9jNjJWUERjUnhVK0lORHBuczAwNkxqelByNVhtWi8xbDFzMDhs?=
 =?utf-8?B?NGkyK1YyaXJXSFNlai8wUGsrWTZrVXBxby91MWhFS016TWlPbW54NXQzZkVj?=
 =?utf-8?B?S29VWVU1VDl3VlUrZWFuaEhWYTB5RmZNL1NEaE41Q1oyTE1xUzJmYmwwZnJQ?=
 =?utf-8?B?Nm5rM0FZVWs1Y3BDYkNINFlKZENNMlZ3Sm1HNDVqbW1nVkIvOEd2VFVTbWwx?=
 =?utf-8?B?R285eEgwT243M2piUm5wRDhFOGx4YzUwRmNGa1NJUFJnQ1U2SzBvK2pjRkty?=
 =?utf-8?B?TW1mMWUvZjdVWkJPaGxDSjBJanRDU1FtRjVaaGphVHhtQVVhTlRWSHJnR3ps?=
 =?utf-8?B?a08wL0pEVlB1V09rSUV0cHovWm1GN0psQXpnNDZRUVdBL2l5YklaRWJhcit2?=
 =?utf-8?B?UTdmSnFGL2lMTjIwR3NTcmxoMmhJbWJtaGJESUJad1psQlQwUWFZVXpsRTNN?=
 =?utf-8?B?bDM0aWU4NHN1TUdyM3dtaCtNT0ZTYmFMNHZaV1oyYUpOZTdMN0x3UE9KanBq?=
 =?utf-8?B?M1F5Vm5LRC9DMlZVa3h4em15V2taMEt6NkhhMHlqSGZEbTUvaVdaRTdoclVk?=
 =?utf-8?B?OHJWY3lySEJUN2dhT01jU3NzT2JqcExqenY4d0tFZDFBSGFWMWZnbkJ6MnFL?=
 =?utf-8?B?N2hNUmllMldVOWdxSkFpbnl2VkdFeUtoMi9acjNEdDlRWllVVUw2OFRCYjR0?=
 =?utf-8?B?S3I5NEpCZi9Rd21ZclBDcjBwQXBWaEZUWkFaZjl4OUllL3lNLzB2U25lZ2pE?=
 =?utf-8?B?VHdVN20rZUJINHJ6eEtHTEtXaDdnNkVZQ0xMREFwbzVWbXk5N2ZRSjN3UzlY?=
 =?utf-8?B?ZGRnSXErWkkxNUJlL2pWaGxKOERjUW5RMlFZN0h6YWx2YThxNHpUbkRwZDBr?=
 =?utf-8?B?cXRKS0hDNUgrWXJVdEtkUmcveXptOHNlMG5VcmxIaDZUamtINmlzdE5ZR2pu?=
 =?utf-8?B?Qm9ZNHpreVI1Y2hGZlVKTVA2QnpqaGVJTzQ0bHFiRW9XNy9PMWxjNDF1Tmcz?=
 =?utf-8?B?WmI1UFRmcXVqQkh6NEFXblBRZ2dIUzQxQUZRWjVQMTFGeHZVVUNxZGl5ZXdG?=
 =?utf-8?B?dHAyb1BMRndCczIxY29CZDhUN21UTk5zdi9VajdOLzVFanhPWTFoRnZmdkZr?=
 =?utf-8?B?NnpaUnhUNkdhWFVVd1BmOWwwKzdhaGJNdTk0V2lHN3NYK2xDQTFEc0pFd2ZW?=
 =?utf-8?B?b0p2MGovU1BOQmJJUFdOVlY3cXJieXBIN0o1cmM1T1RVc2JsNks3Y3A1SXdV?=
 =?utf-8?B?RkFrM2gzN1dLb2FCSTFtRGdPUmdNYXE1MmdocHhURllMbE9pVUszcVRPQzFK?=
 =?utf-8?B?VG82cm53OC9aQzdVZUFmeXBVRU9jQ0dMSHg0T3BkSzlyYXVOWThSWFhNbnhQ?=
 =?utf-8?B?TzJuQ0xXWklNdE1wMEpwenVHRUQzd0NrSFpzVHBJYXl6eExoZzRDelhoeU0y?=
 =?utf-8?B?WkZWcFpranRVREp4dnJoK3dVc3pHeExZTm13NnZpUzRvMkNPUHQyZktkK1M0?=
 =?utf-8?B?RDFiU2h0WGdFbHRaa1lmNEppVENEQ3J6ZGlXeGJQbVovSHZzb25YTXIzQklj?=
 =?utf-8?B?Um9icisvaFU1NDF5MXRKQ0w5VkNobEVNeTJaYVArRHhNVVcyenhST3BrTi8x?=
 =?utf-8?B?MHZTWk5NNUVwV3pWMCtxQWpSN09USTBwRGZmeFZLMlg2Zmt3NW9QK0Q1c1Jx?=
 =?utf-8?B?SlpqeHBONjlBLzBIbzhFSkQ5SGZiSlBEelBRNGRRY0dUaDhwTmZuNGN2ZGQ1?=
 =?utf-8?B?QWMvdHpiUi9JWldVWloxOW1VdTV5WEo2ZGFTbHhSa25tQmE2alh6alU1S1Ev?=
 =?utf-8?Q?ll6mMn?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(82310400026)(1800799024)(376014)(7416014)(36860700013)(14060799003)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2025 14:43:08.3553
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d47498b-beb3-4bb3-0d8c-08dda5d19e9a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A78D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6164


On 07/06/25 8:01 pm, Dev Jain wrote:
>
> On 07/06/25 6:33 pm, Nico Pache wrote:
>> On Sat, Jun 7, 2025 at 12:24 AM Dev Jain <dev.jain@arm.com> wrote:
>>>
>>> On 15/05/25 8:52 am, Nico Pache wrote:
>>>> Introduce the ability for khugepaged to collapse to different mTHP 
>>>> sizes.
>>>> While scanning PMD ranges for potential collapse candidates, keep 
>>>> track
>>>> of pages in KHUGEPAGED_MIN_MTHP_ORDER chunks via a bitmap. Each bit
>>>> represents a utilized region of order KHUGEPAGED_MIN_MTHP_ORDER 
>>>> ptes. If
>>>> mTHPs are enabled we remove the restriction of max_ptes_none during 
>>>> the
>>>> scan phase so we dont bailout early and miss potential mTHP 
>>>> candidates.
>>>>
>>>> After the scan is complete we will perform binary recursion on the
>>>> bitmap to determine which mTHP size would be most efficient to 
>>>> collapse
>>>> to. max_ptes_none will be scaled by the attempted collapse order to
>>>> determine how full a THP must be to be eligible.
>>>>
>>>> If a mTHP collapse is attempted, but contains swapped out, or shared
>>>> pages, we dont perform the collapse.
>>>>
>>>> For non PMD collapse we much leave the anon VMA write locked until 
>>>> after
>>>> we collapse the mTHP
>>> Why? I know that Hugh pointed out locking errors; I am yet to catch up
>>> on that thread, but you need to explain in the description why you do
>>> what you do.
>>>
>>> [--snip---]
>>>
>>>> -
>>>> -     spin_lock(pmd_ptl);
>>>> -     BUG_ON(!pmd_none(*pmd));
>>>> -     folio_add_new_anon_rmap(folio, vma, address, RMAP_EXCLUSIVE);
>>>> -     folio_add_lru_vma(folio, vma);
>>>> -     pgtable_trans_huge_deposit(mm, pmd, pgtable);
>>>> -     set_pmd_at(mm, address, pmd, _pmd);
>>>> -     update_mmu_cache_pmd(vma, address, pmd);
>>>> -     deferred_split_folio(folio, false);
>>>> -     spin_unlock(pmd_ptl);
>>>> +     if (order == HPAGE_PMD_ORDER) {
>>>> +             pgtable = pmd_pgtable(_pmd);
>>>> +             _pmd = folio_mk_pmd(folio, vma->vm_page_prot);
>>>> +             _pmd = maybe_pmd_mkwrite(pmd_mkdirty(_pmd), vma);
>>>> +
>>>> +             spin_lock(pmd_ptl);
>>>> +             BUG_ON(!pmd_none(*pmd));
>>>> +             folio_add_new_anon_rmap(folio, vma, _address, 
>>>> RMAP_EXCLUSIVE);
>>>> +             folio_add_lru_vma(folio, vma);
>>>> +             pgtable_trans_huge_deposit(mm, pmd, pgtable);
>>>> +             set_pmd_at(mm, address, pmd, _pmd);
>>>> +             update_mmu_cache_pmd(vma, address, pmd);
>>>> +             deferred_split_folio(folio, false);
>>>> +             spin_unlock(pmd_ptl);
>>>> +     } else { /* mTHP collapse */
>>>> +             mthp_pte = mk_pte(&folio->page, vma->vm_page_prot);
>>>> +             mthp_pte = maybe_mkwrite(pte_mkdirty(mthp_pte), vma);
>>>> +
>>>> +             spin_lock(pmd_ptl);
>>> Nico,
>>>
>>> I've noticed a few occasions where my review comments have not been 
>>> acknowledged -
>>> for example, [1]. It makes it difficult to follow up and contributes 
>>> to some
>>> frustration on my end. I'd appreciate if you could make sure to 
>>> respond to
>>> feedback, even if you are disagreeing with my comments. Thanks!
>> I'm sorry you feel that way, are there any others? I feel like I've
>> been pretty good at responding to all comments. I've also been out of
>> the office for the last month, so keeping up with upstream has been
>> more difficult, but i'm back now.
>
> No issues, there were others but I don't want to waste our time digging
> them up, when we are on the same page!

To be clear, those others were when we were debating about your and my 
method,

that is why I said it is a waste of time revisiting them :)


>
>>
>> Sorry I never got back to you on that one! I will add the BUG_ON, but
>> I believe it's unnecessary. Your changeset was focused on different
>> functionality and it seems that you had a bug in it if you were
>> hitting that often.
>
> In my original reply, when I said "I hit the BUG_ON a lot of times",
> I meant, during testing. It was quite difficult to extend for non-PMD
> sized VMAs, and the BUG_ON was getting hit due to rmap reaching the
> non-isolated folios and somehow installing the PMD again. That is
> why I say that the BUG_ON is important since it will help us catch
> bugs early. And we have that for the PMD case anyways so why not
> for mTHP...
>
>>
>> Cheers,
>> -- Nico
>>>
>>> [1] 
>>> https://lore.kernel.org/all/08d13445-5ed1-42ea-8aee-c1dbde24407e@arm.com/
>>>
>>>
>>> [---snip---]
>>>
>>
>
