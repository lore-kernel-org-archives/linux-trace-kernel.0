Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020077.outbound.protection.outlook.com [52.101.189.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB05F2F3B;
	Sat,  1 Feb 2025 14:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738420525; cv=fail; b=TetrT6vKGGJBr+4T/8LX0ij+ZtJnsxzK1+fLUURM43NrH8g6cHAjMAQB1BAPLw67eW0A7jXBB2NFXV6wjXceO3AWBk1LMQX/0OPF0mLOVMMDG3waJ0QHX1/Y1x9J5Lki34T8Q4PX6rI4UrrXfSZlChclitcxpQzCpytL5WeL8ho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738420525; c=relaxed/simple;
	bh=6FL2y9mmSYpA6fAkFf7Ix4hhZ+2nFZXlAYX6p8D8PZg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WSUUGRk5r/gkk0Z8hG3yPEhMB/YepSBLJwyMNUgNlICqR/+6AokCZY0+iV9kaCD/YOk3eXRki+P07Y+xwarM7wIgo9xKmi5pedvZgy3P187Et4DmYy7prkGJh1S7IxZvmXyI6slMV27blGa+gKjZ8bnKkhFhGIXD3pv59rKNVDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=YSUni7hm; arc=fail smtp.client-ip=52.101.189.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="YSUni7hm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ENq3g1t3AWiPjDaCfU34R0MrVD6yO7XLkGfu5J29pGIA55gkSxqdqP2S4z+a07O0aaoCeSpA5MHRAgzrPGTboa1NOg/h5IQdFYNe/L4lVaF8Q1wmek6y4H9XF66EaLlkqqdsC2WlScCds1fYMHLKHkpUsWVJynqbFDazg6gvi6uUqF6aXlgElbnpkobNnejNMAseUwiWL3V3QN7kHZwEvYeFQ2oKrAkd9RNKTcO/hRVG1xtCj1UYsGvNcsXQkCJrnbkjboQZgy6sdyIJeB5qMG5X37CACmBSNRtxMr1afInryKQzBdatsPurdLF39d5C+P0CS2g6KSWZTSkledvrzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gCmflKfSsGbEjcCsv3BdkPtfHfQsQroHQ2iWS5b68E=;
 b=VGqFiYHXaAVzhjruMvgSlUu1LuN0nW4aT2cRARlZRxJyKNG1Mx6ZoW+pyq291AmjP9GnZbnBtDLqjPdq55BAkfamKqSIIa9dlJzVskyqfRzwKQv4J8KzGee5R7qIxm29H65n+/SufmW/fvcmxhYKmaxy7KXT6xYvjov2pwJ6xVgSQLf2tMPm0f6hP/1GVrW+PN+46ZWVYLoOzMWOIhBjvEktTibhJZ5tx7Sd32nsmHa6QWaFZgMB4VDoRvSS9x1kjnBcuULV6f/BY9veZJvuH9RP9+QFOwf6dRnIUdVuopG9KVDy/1ZYFq9jKSbH06WxeQuSTimJi1pYJ+qCFC/DSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gCmflKfSsGbEjcCsv3BdkPtfHfQsQroHQ2iWS5b68E=;
 b=YSUni7hmcDmPNhvi5SOYt1RgjvcEhUq53HlsC46qj6jXjhHvfyv3hFwsZ0ZgiVaLFBSWC7XdSy5eh1SYm1N0QbGDBbgUg1dYrCMAa9oomV+0MzQd6fQSHbon+9KkRFqxAN3l+2XO38okePgBL/PEMLNJm6JZQqERUBO/Pt7gUKIj5Q+ZMalrVEwyinM67/wJypc01zGWjfg+lgmLl0TaqZ5oQBZsGkSRwI0arjO4q57zyyeTotN6v50gTEBOstqj96gmjFyItMGyHiIVWr4PkHe4Cquzx/lvMu/ipkrRGtk07wPm4DHgaQWDbTjudb2YN8JsxERyDVihk7QxyWs/nw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT1PR01MB9049.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:cc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Sat, 1 Feb
 2025 14:35:20 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8398.021; Sat, 1 Feb 2025
 14:35:20 +0000
Message-ID: <e83ce086-b55f-431a-a499-f83a434b70db@efficios.com>
Date: Sat, 1 Feb 2025 15:35:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH 1/2] sched: Extended scheduler time slice
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>, Ankur Arora
 <ankur.a.arora@oracle.com>, Linus Torvalds <torvalds@linux-foundation.org>,
 linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
 luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, willy@infradead.org,
 mgorman@suse.de, jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
 boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, jgross@suse.com,
 andrew.cooper3@citrix.com, Joel Fernandes <joel@joelfernandes.org>,
 Vineeth Pillai <vineethrp@google.com>, Suleiman Souhlal
 <suleiman@google.com>, Ingo Molnar <mingo@kernel.org>,
 Clark Williams <clark.williams@gmail.com>, bigeasy@linutronix.de,
 daniel.wagner@suse.com, joseph.salisbury@oracle.com, broonie@gmail.com
References: <20250131225837.972218232@goodmis.org>
 <20250131225942.365475324@goodmis.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250131225942.365475324@goodmis.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P191CA0019.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::9) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT1PR01MB9049:EE_
X-MS-Office365-Filtering-Correlation-Id: 18f3f004-e34e-437c-a85b-08dd42cda79c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WjVCZGdLa2xFNi9BNDVLV3FxTHNrK2pyMTRtaWx0TEd4bFRyaGlVaUovSTUw?=
 =?utf-8?B?Y2RaRXUwTnI2emhzZW4vQ0Vha0RPWm9kbWtCellRU2FtS3d2VkQ1T2hrMm51?=
 =?utf-8?B?U2VJNm9QcjN2Ti9MOHl5VWx5bGNQV3FoOGhZYkhVR0JtR05wOUIwT2wzWVVp?=
 =?utf-8?B?elR3TTVua2Mrbk9RWEtTWTRGaExFSHhaQmhMcWd4T3hjRFpBVmVFbHRlNGhv?=
 =?utf-8?B?N28welpENDZkRUhGdjYwYXFscnc4M1dqVDc5R0ppRTJKR1ZzcWpHQnQ3Nk10?=
 =?utf-8?B?c05NT25yV3MrSVJlSU9oNkx3Zm1BcnR4cXNwV1B5V2N4RzJtTHFDbG41L0Z6?=
 =?utf-8?B?MTYwcC8vTGM2dVFtWFpEU1RERDcyODZPV1hXOHRaVlM2czZUZ2dzRTZFcWxO?=
 =?utf-8?B?ZDljeUtnV243OFd3eDJoMkJFWWlKcXUvN09ka0NaWml5NTdwWFVUK2pNYmZS?=
 =?utf-8?B?K05RZmF4eXR4SFlQaWpBd2wzc0FVam9MeGRGNjgzUEtNeGs2bUl4NEVzZmJ3?=
 =?utf-8?B?Y2xieVJEd1lwSW83cXlqNUNlRTBUOHdEOWlzOUpocW9Uc0FmUEpXbVFzcnI5?=
 =?utf-8?B?Y0pWUjYwMXhPa0tkazhxNFhPNmp3d0RuRTBFTFJwWldTYUlremcvNndMLzJo?=
 =?utf-8?B?OHBuODdpR3ptSm5IS2UzYzFMQXgwWlBnUlBTNFE2MVg5RHlEdmI0Q0xzeDFE?=
 =?utf-8?B?T3lHdVVYV21pRklyaVEwcmlyWGNzaFZpbDdzYkJ1N0pjT00vSThCQ1NzZ0VZ?=
 =?utf-8?B?SHFSRW50SzhLb3o5VlRSQXh5a1pZeGVjbGNiTlRhckxsbDJaUzhndjZuYUlO?=
 =?utf-8?B?WUxveEJkU3E4TVJjNE82K09nWDROWFd6bTl4K3hjTUkzR2FJVlNBUldSVFh4?=
 =?utf-8?B?TWM3dVZ3dldQamdTREE0M29pWkxmbElNY3FhVnB2RE5lYUtHcHcrNzMxVDYw?=
 =?utf-8?B?MjBVYmMzYnY0dmJ6NWE2OXk2NFdOZHRXM0dSUTc2MGd3cEpkVkFrYnRtSStD?=
 =?utf-8?B?Y3Q0Z3BYUFJhTGFlNitTeUFWc0w1Ym00YTZKK1J6NHNwc1Y4WTM5MTBtVk02?=
 =?utf-8?B?YlVOOGw5UHpkWURhOWVDc0ZnTDFTeDJXN243a2Zkc0ZZQndPODdxYnVuQmM0?=
 =?utf-8?B?OGNBOHdNT3RUNjIrc3V4WC9FdWdsRU5GYnNYa3lzVmFOcXh3VjFNcVdsK1Jw?=
 =?utf-8?B?Z1FtYWhwemQ0OE1QY3JxVXkwOXJZUlFCUTY5blFOc1V0QkVKaUJkbXk0MUZv?=
 =?utf-8?B?cjcxYTFISU9wN0huUGg0TVc2Q3Uwd1p5K04rdkREempLOFdkcVNRc3VjdEtW?=
 =?utf-8?B?eEpUZGI0dWg3cHQvYkJrTVlCTGZDdlFnVTk3YXVZNnRpQTFTOG5yTVpidFVj?=
 =?utf-8?B?MTlVMlN6R1B2VXFneEJtUnd6T0R4cEpWdXlXNm9Pb1hxMnpjRmhvV2tsZCsv?=
 =?utf-8?B?Q29aTUpwVFRSc1AwZUZoZGppMGFDY0xjc0k4UFVoZ0RsdllqeVV2M2pZcHlJ?=
 =?utf-8?B?aVZmQnZwU0dGMExxdDcyWVMzQzJsMjcrWHFObTJPZURIWERwUHRHOElPSDFj?=
 =?utf-8?B?SGNvTElZbnd1NVJieGpvaXJGS0VBS0dSamZINDNOTnpGNkp2ZG1LME1KNG9G?=
 =?utf-8?B?eDR1WkQvZTdYaUw1YkRVYjZnL0Q4MlZWOUFiUDl5YlNFbG16SWpicG1FUUVB?=
 =?utf-8?B?Yi9OSmtraHVuMmNUZjcrS2RwQlNiV2s4YXNlM3B1L2dESHFsL0QvVzZ6MEla?=
 =?utf-8?Q?Fqgu0jBlfx00YYMd2JC27/9bKGXn/1XwgjBerSv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aG9nemRrbGJIMnk2RVZieU1KY1FwY1hzUmZZUGJtOVM3TWtlSnFwdlRZdUx3?=
 =?utf-8?B?UjM3N0x4bXh2OW5hcnJDODc0Wm9OQlV5S3JlajltcGY3NzcwSUI0aERlaWlE?=
 =?utf-8?B?dDZhTmliTkROQndwV0VQTEtZblpQZHFPMU1rZUIwNEt1cVZabWhBMFNNUHJ5?=
 =?utf-8?B?WjIxUG53TzdzYWtURW5KMHZPZmNsMmNqSURZMVgvRkxoYXBhTzh2dGg2UzNX?=
 =?utf-8?B?VVZMdGg0b21QUDljaXVYbWZNK3lSRmtjZW4xU3hra1k2bFRQM3FKR1dGVFo3?=
 =?utf-8?B?N3VKa05YYnFVU1c4d2lZUm91dTZ1MTZzdXNidlJISUlFWFRKdVN1bG5wUy9h?=
 =?utf-8?B?aHN5aU12WUc4dE9tdnA5THFvOHRORGtYNEx1RTdSRExhenMrMThZdGRNbDJM?=
 =?utf-8?B?TUZpa0xQZnIvdFM4NmZlUGFUYWkwZmowSStXT3ZvcENOZWlETHNiRkdVajhx?=
 =?utf-8?B?SzFqeFhMeDl2Z1VOK252eVB0eElpakR4RitkRktiOEtWM1JZaHk0T1FLODVF?=
 =?utf-8?B?ejVjNXNPMEsybDcvbVF1Q0F3S043R0t2OTgzZllZdVlIRXpsWjE5V1BLS3hT?=
 =?utf-8?B?endYeGhySGUzelUwR2RwUDRpRmlZUlJNRVpHdGlORW1KL3A2cC9QK3lqTWVD?=
 =?utf-8?B?SzJEbU4waGk4M3gza2VHdFJoQ2tZRGZPVktBaUROWElBVXJLbUhqclg0WkUr?=
 =?utf-8?B?MTBhN0p3bkErRHNTWFlSZWpVZjVnRFMzcDBZOExPK0ZobUd4bDcyTVA2NWZh?=
 =?utf-8?B?Qys5a1BPamN1emtwUFRMUlppZ2J2Q2Rzc1hINkpVQVlZNjdwOWoya0NNWU1O?=
 =?utf-8?B?Q0J2QzJMZytCeU56WjAxeDMrQXV2SUliRGVKNHdXbkFSOUxHa0huc01icW5I?=
 =?utf-8?B?bFArRFU2N1dLK3QvQUxUdUlwSGVaZTQrMVhzSVpjQlZyd3RCSTdsZ05PajM4?=
 =?utf-8?B?MVBhNnJDdk1oZDBRcUdVTHhBZ0hwK2xOYWF1eEcxT1ZyOUV5QnluMVgxQ2hW?=
 =?utf-8?B?dTJmbFQ3NEtlaDZjS1YxVVJ1WEdReEpDWnF5V09oaDlJUkxCMUhIRVRHT2JF?=
 =?utf-8?B?NlhyUFJNV3YxRTF0RnJQVUlHM2lSL29CQnlVck0rVHRIWE4yb2x6bkg4dXli?=
 =?utf-8?B?WVBpKzhVeVF4SERLVUxQWkRZc094UUhtQStjRVVjWUJrM2t0clB3VTduNkNK?=
 =?utf-8?B?WEJMNnEwYTJidzBtZC9INGRnWFdJTWdhcnZUcTE4Um5lL0VTVUZpdmxNWHE5?=
 =?utf-8?B?bXFNT3ZIT0pQR3RaQzBBZUZyb2tGd1lQNmZCc0lMWDhYZE9zR1ZEKzY3TmIy?=
 =?utf-8?B?TThqLzJqTnZUK21STFc2dzltREZrL0diYlUzTVIvSWFrVE4rQ3h4Ujc2YUFZ?=
 =?utf-8?B?bkJkVFVSaUpZbDNxVVVYZ2FTWm0xVDBzdVBUcExkUnptU09VL1BneDZlWVdX?=
 =?utf-8?B?V2ZVTm9WVDBUYkdxU1pZWXVMM3o4Zks4R01scUhLUC93aWV2czhCRFhLWklx?=
 =?utf-8?B?azlCalhJRnI4UlZLUGU1K1YxUVhSdWU2YndrVllOeWo0bHdocDRNWTZpWkZ1?=
 =?utf-8?B?VVBjeUs1cmxwQy9XM2dFakhMUFZKbjhjT0xxMjgrU3Jqbk5EZDVSbUUrYVBj?=
 =?utf-8?B?emVRRFNOYjl3a3k4aE1ucmJrMGgvajVkVzV6dm5ZUHV1YWpXeG5UaGI5dGVI?=
 =?utf-8?B?dXR6SVNlK3pXWUZ6VlorcHNZRyt1VFhhMGxKZDlsb2pnL1R4OTRHWlNSVWdT?=
 =?utf-8?B?N1Z4Mnd6azZsMVRHNEJYcHNldXlESWtIQkhZZ0dpQkYzNzZHOGhCQWRFQmtT?=
 =?utf-8?B?UDNuZDY4Ymtqd0VOYWNROHhVU3VmUTFlNlB3VlVGOG9RVUZ3aWZZYWdHbm53?=
 =?utf-8?B?ak56blJndnlxalBpR3o1Q216VFJsellCMlVTZEtMaGRtaUZpZTNnRzB0U1JI?=
 =?utf-8?B?bTdER3JoR1doeHdFS2dsQ0k4M1pJUjJaaERsMmpBTmxBTkZuc3NIdTVPcDUz?=
 =?utf-8?B?YWkxL3RzVmNrZk1QVFBDaFFsWTd6NXBOVXoxdEZXUlF0OEZTMnRaZU0xZ3RL?=
 =?utf-8?B?WkxkQ3NrOXp3S3hST25vVjhkNnJqY1FDNjlOZUdPRVhNb1hqSUw4QmJKbU9q?=
 =?utf-8?B?TTRYcjlDTzlpRFZuQnRUUjJkc25CTGdFMDV5dFI1LytrOHM4SjhWbFZSNnly?=
 =?utf-8?B?aGV0anc0ZjhnbXdlVTQxZVQzeUdYazlHRE5qTFVmZWVYR296c0dkL3c4WE5h?=
 =?utf-8?Q?oPHL+IWKnbLlnoujwUHhPtqzMo+nszF7R99AU0biuQ=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18f3f004-e34e-437c-a85b-08dd42cda79c
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2025 14:35:20.6992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3s+uL/I+/xbbF9nLgK0saJJnlqX3rKsLDIlFa321ZckBa2eL9GilD5lLnszpY8XVa5+WW6a8s2Ku1OxvK1zDXUZq5yIIiVxGAnmoD5MQbCg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB9049

On 2025-01-31 23:58, Steven Rostedt wrote:

[...]

> @@ -148,6 +160,18 @@ struct rseq {
>   	 */
>   	__u32 mm_cid;
>   
> +	/*
> +	 * The cr_counter is a way for user space to inform the kernel that
> +	 * it is in a critical section. If bits 1-31 are set, then the
> +	 * kernel may grant the thread a bit more time (but there is no
> +	 * guarantee of how much time or if it is granted at all). If the
> +	 * kernel does grant the thread extra time, it will set bit 0 to
> +	 * inform user space that it has granted the thread more time and that
> +	 * user space should call yield() as soon as it leaves its critical

Does it specifically need to be yield(), or can it be just "entering
the kernel" through any system call or trap ?

[...]

> diff --git a/kernel/rseq.c b/kernel/rseq.c
> index 9de6e35fe679..b792e36a3550 100644
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -339,6 +339,36 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
>   	force_sigsegv(sig);
>   }
>   
> +bool rseq_delay_resched(void)
> +{
> +	struct task_struct *t = current;
> +	u32 flags;
> +
> +	if (!t->rseq)
> +		return false;
> +
> +	/* Make sure the cr_counter exists */
> +	if (current->rseq_len <= offsetof(struct rseq, cr_counter))
> +		return false;

It would be clearer/more precise with < offsetofend(struct rseq, cr_counter)

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
