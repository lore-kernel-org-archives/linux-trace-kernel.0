Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795788782;
	b=beSyskzD/XVcA29kqS8KW8JmjZER5cd6ioOJzlww6KfZBP/3gfawFP4SzMGQfmRkP8Be
	 P6xILj0OQSnATDDOYZoZaO3lEja/+7eI5pG3fvyt8/WKxSS/jOj10rMJ7gxuXBV2zMtk6
	 n1gD8LapL2b9It0Ai1DBx+IIYSZ7xcXg3AeYRkqR+2nRDyakKLjEYMX1eB939YJB3NNNs
	 9Z8P/03HJPvFyHOyQ3L0iKXlNBnoYpJ8pQeUUAbbiTad2riqNM6MkL0w10eoMgheBmgPz
	 /uZFalMDjn9fej0PAYt5mvb/Vt1H/BEcUA/fuBO0WI6dbRrJAtmUx5fQVEbmBQhTVvQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795788782;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=I915MK2zBNcDy5Tx9sRF7zlmzP5AZbkM+YEEq25kDxU=;
	b=Pavo7EQ5iU/HWoYPTLnWC6rF40MCZMDzviPVCOf6G+F3OAtjqWOgTHdpnn14UrXm3bdY
	 IE29mo9Le/9GvKKcGi7xwdVRHJh6MKTouAsdbfgTzx+QI3h/PbAjnZ4uIQf3gwkzjmmdJ
	 KwlL8rxZSYj/G+GBo961QBmI0ldH8Kgz32+g9+3cP3H6zE6s0mthSB6qPhXEY2F+hY8uc
	 VgEwE6i42ZhN/WAkHNoH2koyFRVHTxUrBfxY/f3WyistKXCybAZ8Pm1lJHxJCdqOLMtAY
	 EEXnCzDRrKprbNh2PuKqwB025DhKhi9b68oeo5JibuO6K5/1mkQQsqy7N/uXXXPesMw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b="O5XpdN/N";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.7
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011007.outbound.protection.outlook.com [40.107.130.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89210606A31C;
	Fri, 27 Nov 2026 14:13:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89210606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=O5XpdN/N
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OniuHPHeEmikgEfwjgXQTzhJh4R+ZDkdtZx2eld4JKf59Tg3Fp1Jh3qlLAUk2pumXIm4XvzFMqRHFwyQbuOKGsWD5PDHu5AFlE+9IV3EOVv+nGUuii20kGuvTfJ2pmi43/ZPZsmDyYFlca9zBOlxfTBTviTKxmkcKBcnWr5U7O3jdNA+R+mWi8LDAZU1TdtpyFnFE6yWCKB3+tVKmYbE6rj26hyXA9GTOyiz88LHw7TaMhJv30/g1vi7bWF2hu26S2aLikdN0gM/64Gi1QRiSb5L0EVMgLILS4YSgFZUR7Qh6XykaQk7RKzwvhTFTKcwJPwsp0JGJp9S0bMmNQEQ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I915MK2zBNcDy5Tx9sRF7zlmzP5AZbkM+YEEq25kDxU=;
 b=D/hRkAeqkFlqDzqaAHiLqUneEuhMKCnX25mQ2RYzqECfYMb7TdWXNdNGQVrqaxXiaMbPwfgTDGJLdFylrvId27h9ptwizSk9NEY6snJsh9z3iq3n29A6aHcA5NRdjmF6SgcJUJVzAB+pJYAxzE+mG4qzRFm5ulXd8pdTjGMAw2pXyMgSSUe+sOkxEh2w07efm38BMO3ewWYW4rMUGJGkIJIyVmo89o2mWSY2s9TAT2vZZztAVNvDsfDWG71ZxbOmaLiK3mn1cMUq2Ltv0UJR54Vm8kIAXdpgFlla1l0YQcp+qURuqwrFfJPzzLB/fh90+mfuh0fduYpoah6oWbx5yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I915MK2zBNcDy5Tx9sRF7zlmzP5AZbkM+YEEq25kDxU=;
 b=O5XpdN/NGUU8IRnf2tLKvvlXmU/RwNx4aISXDu0OIoIJ+g1CrADY4pI2vDGgzElgKbVJ0llRA8DvzeRDZALe2wnkTxNF5dF+/oSuwCmVcHFdcAjU5xh/byP82Oz223kNlIR9nhGbMfHVh0oBFWO8E1mUGP/08U2d3/GuQXP1wimVKUKtWWYy7fj2pJuuc6AJYclo9l4+G1BeiX46BAvOqherv4VYuSk0JXWbPG8mMFfpjZaOvBv/vBWW2BT0nFiN+4VXzVG4Snl6nvIqgHOBitIC4we8tgzaIXvibPcN1nshyfLvms9+/T52Ykz/hk8ImfR+VZDoYOW0FwAZ8wo9ug==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DB4PR10MB6240.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:380::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.688.4; Fri, 27 Nov
 2026 14:12:55 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0688.001; Fri, 27 Nov 2026
 14:12:51 +0000
Message-ID: <adebe91c-09cf-40b3-9780-998cea432226@siemens.com>
Date: Fri, 27 Nov 2026 15:13:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] rv: collect per-edge dwell time for per-cpu DA/HA
 monitors
To: Gabriele Monaco <gmonaco@redhat.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 rpm@xenomai.org, jan.kiszka@siemens.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20261127113609.650286-1-tobias.schaffner@siemens.com>
 <20261127113609.650286-4-tobias.schaffner@siemens.com>
 <edac7605937c5fd1a02458e171ddfa4d5e6c1a36.camel@redhat.com>
Content-Language: en-US
From: Tobias Schaffner <tobias.schaffner@siemens.com>
In-Reply-To: <edac7605937c5fd1a02458e171ddfa4d5e6c1a36.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0361.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::17) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|DB4PR10MB6240:EE_
X-MS-Office365-Filtering-Correlation-Id: c469bdb5-105e-44fe-8f74-08df4c9085d3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|366016|23010399003|1800799024|10067099003|56012099006|11063799006|261028144727099003|261021123027099003|261022105027099003|261021135927099003|261021121427099003|261026140227099003|261026121527099003|261102123227099003|261009223027099003|22082099003|55112099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	CG/xy7ukqNviPhowvyRtNIvC2y3XsVFLEtb5dMwkIHiGNf1nQnkCt910p382FPdSeD1A+ypMHmWIiXmO4tbB3LxYHl0k3APktF3wBc99OP/mepBm/AlVwxGzQNUpyzxqeyH1sN/nAAhOonk734K6t4qBP4/tAJGzGRLfZ4FjFim/bUgDQuL56E46/X48ujPWDoPOgPgI/mYIU9bISIuGnbtIm/cxcwtSNes2s7n79skQupCe19yi0TEPt82E5iICLKvbApk6JHfSOKD8UHlmQfB21PU1uS5Czk2cnP4jDqfd9scQBZjjQdDjbZ2GpgjAts7rxjCp9kR8B7EotzEBKHO7M5+NY0oXGhC7AGnRUZGhIyQCVLGCjTl8Vve1XA5AMyEvWwMdVtq67j5z3PrCdr7L9qRYgU5eGKysripPsUV+isBTC9zN3Z+hLAbUXr//4eoGvMikiVBZpDJoxAYYB9ViA3HBEmtXImcr7W12Q9qM4ou7/TeWr34dFYLZ0C0woZz3R2QrgHMfwKAhr4HPNFhyEsrmq3Qr3uHdsmuhVKZYt+OgxLp2SiRsXpzJVtF/IxbU9Vft2Eg0fwAh+8Fhq+YItJihVk76JKOQR+ZM26SOPUcvGAd85kT6WOa5WhWzMJp8BQvG8BmE6mrC+SnfIya93AMErIRyQpLlCxajpV4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(261028144727099003)(261021123027099003)(261022105027099003)(261021135927099003)(261021121427099003)(261026140227099003)(261026121527099003)(261102123227099003)(261009223027099003)(22082099003)(55112099003)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVFHaXFyNW4wVVVMSmhUSXdYQmNSZmJmUTA5MHh1YSs2eGl2eWpJWXBuS2ky?=
 =?utf-8?B?NmlaOUlPUW5yWk4wTm9mQTlpR0Nwb0M1MUsvcm9QWDAzSmpmR3hXVy9lRmgv?=
 =?utf-8?B?amw4bVpKSUQ0aHJxQ1NiSTJzRm1ldXVEWGZIQkhzditxSG12SndhdWFPMG4y?=
 =?utf-8?B?bmtmemx6bEZZNVhnUm1SSm9zRytkc2NiS1BibUdPRzdZbDN2U1c0TitBa1pn?=
 =?utf-8?B?ZlFxUEZGZnQxR1djQkJhYkIrYXRjcGNlKzlrSVBybmd4SWdIYlAwNW1QK05k?=
 =?utf-8?B?S3FkMHZEaExCMG9ueDQ4Y1luRFh1dEQzVFhMUTAwczBzZ2tycXVTOTdaaEsr?=
 =?utf-8?B?cUNMNkhQa25NaFVWNCtSWThYYmFFbTY5Rzd1ZUcxWmo4SWNsUlVrUU1ZcG5t?=
 =?utf-8?B?VnpjRjJrVmVDNUxTN0ltS2F6b1ZKZm5lQ2FxTndUYnRVOWVuNm53M0xlc0g1?=
 =?utf-8?B?VU9BUE1oTG1QaTFlMkRUWEQ3YTczNWFJdzFzUEkxMTNrRzExUWNDUDRsbVBo?=
 =?utf-8?B?eXA1SFpHMTliRGhzeEV4WG5LSWc4SVVUNjJBQVZ1N1lWZWRNc0NxUGgxa2hx?=
 =?utf-8?B?TkZpSEFKa25keVkzajJXaktQMDBCQjFWZmJIV0dEUmRrZURXRkc2SXN0ZXlP?=
 =?utf-8?B?QVp4aGwvcEgwc3AwVytXRElqVzluUTFJUzByVWlWMFYyL1FLSk5vaW5yb2RI?=
 =?utf-8?B?c1JVb1VaYWNvVXdhSnlSd05oN0EvaWxvNENDMm9LaDFFY05WWUI3Y3ZoMkd4?=
 =?utf-8?B?VWtqbm9UWm5OMUJJT2RsRGQ0Q3JQMThQMmNoUXB0UWNNM0xRQUJKK2VZVlI3?=
 =?utf-8?B?M2RuL2tabjhrZ2g5aHVtbXJ2SUkvQ3dBblp5RXI3VGFjSi9yQUVoUzFJbFNw?=
 =?utf-8?B?T3dZRDZuUkZaMnB0allwNEFZMWxNd1AxVVpLb2pjeExtVFFzTEJ5V2tBbEl5?=
 =?utf-8?B?ZXdiVkxiMzM1OEI1NGlHWWJWeFN6UGNzTGhHN3d5cXYzMTVQdnhZamR4dXQ0?=
 =?utf-8?B?VjYxQjRDeGVKSXNFbE5DY01GY2J4Kys3VEthcS9KWEYyYVNRK0FFUDB1bUdX?=
 =?utf-8?B?SmdPRVBEWXQwdE93MmtMS0lmRTM0V1MyUE1OUWFWcllkZTUyS2VzSi8xRnFJ?=
 =?utf-8?B?WjVNNVhOa3VkbE5pOU5PZTdlZFVwdGRsMEhEd2xRMnMrNDhrdXVOUkVLaU1t?=
 =?utf-8?B?d045bXdVSk1OL284SEpmSmwySXhyYXcxWWxGWmpWaGpIbjAzaVQ0YzdZcUJj?=
 =?utf-8?B?bG5hMlZsQW1ra1lKeVM2eTNlSVNaNVphM1JPVVd4RUpaM1lNd0FiR0VSRjZ0?=
 =?utf-8?B?azhwNUZ2L0ZXdHBhUEQ0NW13bFpqWXkrNXYydHFrTVpuanBIYTY1Uyt4enRY?=
 =?utf-8?B?Z1VtR2pzdlNwMzNBRnBnTnlkZHFLbDVyMEJFSGhhcHVpTGtWN1ZYbWNaYWxr?=
 =?utf-8?B?YlJuK0UwT2tZME83aWdYUi9RTkVRMHNGZzBXblRCR3FSa0dha0t5YmIvalF4?=
 =?utf-8?B?eit5ZWF5MmtLa1BnZDZmZithNFM3bFEwUTF5REx0aGcrK3dXeHJNWGtvSUVo?=
 =?utf-8?B?THVSeTFEay9YeUw4Wm5ZVmZ1dmxKTnFQOHhnTENielVwblMwSUJ1bkcydmdR?=
 =?utf-8?B?cFhYbUNQRml4U09lc3NNRWU3RlN3K3ZFdWxkQVFBMll0U0RaUkZTMEEzY1ZF?=
 =?utf-8?B?aGpDYWVMZWYvMmFlM3VqeEF5VXZNMXhQcjVUb05SWEZtTmd5UDRUcFFudDRQ?=
 =?utf-8?B?b0JVSEx1UUk0SXdMYzlCb2o2RVRzazNFYnNQMnFNd2JSRy9KVkRiRE5mWnIy?=
 =?utf-8?B?Mm5VcGUzM0xGRUdyV0hQek9kUk9sRWJRS000Ri9HcFU5czNhZThINVdiZDNP?=
 =?utf-8?B?Rkhzd3k3UjZpS3l5L2REeDRZOENOUEk5Nm1xbnBmZzF2OHkzcDZjUGxweVkr?=
 =?utf-8?B?ZUs1OGtUcWlCU1JPeGtRQjFLaW9LKzlVMmRYYTBEUDZIYVFGMHR1VVRERisw?=
 =?utf-8?B?ZHVyVWdMNFM5TTQzcDk5TDB3Y2prNlNlaDFZRTlnY3IzSnZGNGVHQ2xhUGFm?=
 =?utf-8?B?eXZWOEdJWllDN2lDRFJrTUZTN2sybGNCQ1BGcTd2SmZNclB4bTN6QktzRVov?=
 =?utf-8?B?MXNod3FJTmlEaXlMblltQUg5K3l3dzB5cEM5SE9oUWdBMjJBT25ONTlJYnpT?=
 =?utf-8?B?MThPdXhHVnhid2E2SzBoL0w0WjdNdzNtOEZpdUNVUWw1clM2S3J0dUI1TzQw?=
 =?utf-8?B?WVJoSk80NzhuK2gvVFVRdGN0V3lQckg4a2dHSGVaK05yMXlLRnM4bDVadjN6?=
 =?utf-8?B?QlVzY2RuY1BKdzEvdjJBeWdOL3Y4Y2k4R0VHQVdJRU9KMXRERGZLeEdZd25j?=
 =?utf-8?Q?ssHcm16TxIanqX/rmsCIRq86137pdnWG60QTj5Hl/CnVg?=
X-MS-Exchange-AntiSpam-MessageData-1: AjDMxqv4tlfUOm6IwpPouls0hqUU6s9cgY8=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c469bdb5-105e-44fe-8f74-08df4c9085d3
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 14:12:51.6239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zYWVFJKOvrxaa6fpllCTW1CplHLJf1opI3NzoCFKujz/IqsFgLVaWI4S9A+Oi5ZNrpqlCq/tEYHSVpFYMU3OUgx4QGy+5U4CHBXrbDmpe2s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6240

On 11/27/26 14:57, Gabriele Monaco wrote:
> On Fri, 2026-11-27 at 12:36 +0100, Tobias Schaffner wrote:
>> Hook the edge-stat facility into the DA/HA layer, so that any per-cpu
>> automaton monitor also reports how long it lingers in each state.
>>
>> Account a transition as soon as its state change is committed. An HA
>> constraint that rejects the transition can therefore reset the monitor
>> without leaving an accounting window for nested events.
>>
>> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>> ---
> 
> Looks good to me, thanks!
> I'm taking the series.

Thanks for all the support! I will continue with the missing bits for
per_task and maybe also per-object and global monitors soon.

Best,
Tobias

> Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
> 
>>   .../trace/rv/runtime-verification.rst         | 30 ++++++++++++++
>>   include/linux/rv.h                            |  2 +-
>>   include/rv/da_monitor.h                       | 40 +++++++++++++++----
>>   include/rv/edge_stat.h                        |  5 ++-
>>   include/rv/ha_monitor.h                       |  2 +-
>>   5 files changed, 69 insertions(+), 10 deletions(-)
>>
>> diff --git a/Documentation/trace/rv/runtime-verification.rst
>> b/Documentation/trace/rv/runtime-verification.rst
>> index c700dde9259c..ac16b5532e86 100644
>> --- a/Documentation/trace/rv/runtime-verification.rst
>> +++ b/Documentation/trace/rv/runtime-verification.rst
>> @@ -229,3 +229,33 @@ For example::
>>      nop
>>      [panic]
>>      printk
>> +
>> +**monitors/MONITOR/stats**
>> +
>> +Present only when the kernel is built with CONFIG_RV_EDGE_STAT=y and
>> *MONITOR*
>> +is a per-cpu deterministic or hybrid automaton monitor. The file exists while
>> +the monitor is enabled and reports how long the automaton dwells in each
>> state
>> +before leaving it, timed with local_clock() and accounted per outgoing edge
>> and
>> +per CPU.
>> +
>> +- The first line is a header naming the columns.
>> +- Each following line describes one edge on one CPU::
>> +
>> +   cpu edge label valid count sum_ns max_ns
>> +
>> +  *label* is "state:event", *valid* is 1 if the model defines the edge and 0
>> +  otherwise, *count* is the number of times the transition was committed, and
>> +  *sum_ns* and *max_ns* are the total and worst dwell in nanoseconds. An
>> +  invalid edge always reports a zero count.
>> +
>> +The counters are reset each time the monitor is enabled. A monitor that
>> starts
>> +on an event leaving its initial state does not know since when it was in that
>> +state, so this first transition is neither counted nor timed.
>> +
>> +For example::
>> +
>> +   # cat monitors/wip/stats
>> +   # cpu edge label valid count sum_ns max_ns
>> +   0 0 preemptive:preempt_disable 1 4210 95501200 183200
>> +   0 1 preemptive:preempt_enable 0 0 0 0
>> +   0 4 non_preemptive:preempt_enable 1 4208 3812900 42600
>> diff --git a/include/linux/rv.h b/include/linux/rv.h
>> index bf75cf2300ee..d83d1a98344e 100644
>> --- a/include/linux/rv.h
>> +++ b/include/linux/rv.h
>> @@ -33,7 +33,7 @@ typedef unsigned int da_state_t;
>>    */
>>   struct da_monitor {
>>   	bool		monitoring;
>> -	unsigned int	curr_state;
>> +	da_state_t	curr_state;
>>   };
>>   
>>   #ifdef CONFIG_RV_LTL_MONITOR
>> diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
>> index 6fc5ef8142ac..942b35428ccd 100644
>> --- a/include/rv/da_monitor.h
>> +++ b/include/rv/da_monitor.h
>> @@ -17,6 +17,7 @@
>>   #include <rv/automata.h>
>>   #include <linux/rv.h>
>>   #include <rv/kunit.h>
>> +#include <rv/edge_stat.h>
>>   #include <linux/stringify.h>
>>   #include <linux/bug.h>
>>   #include <linux/sched.h>
>> @@ -105,6 +106,14 @@ static inline void da_monitor_reset(struct da_monitor
>> *da_mon)
>>   	da_monitor_reset_state(da_mon);
>>   }
>>   
>> +static inline void __da_monitor_start(struct da_monitor *da_mon, da_state_t
>> state)
>> +{
>> +	da_mon->curr_state = state;
>> +	da_monitor_init_hook(da_mon);
>> +	/* Pairs with smp_load_acquire in da_monitoring(). */
>> +	smp_store_release(&da_mon->monitoring, 1);
>> +}
>> +
>>   /*
>>    * da_monitor_start - start monitoring
>>    *
>> @@ -113,10 +122,18 @@ static inline void da_monitor_reset(struct da_monitor
>> *da_mon)
>>    */
>>   static inline void da_monitor_start(struct da_monitor *da_mon)
>>   {
>> -	da_mon->curr_state = model_get_initial_state();
>> -	da_monitor_init_hook(da_mon);
>> -	/* Pairs with smp_load_acquire in da_monitoring(). */
>> -	smp_store_release(&da_mon->monitoring, 1);
>> +	__da_monitor_start(da_mon,
>> da_state_entered(model_get_initial_state()));
>> +}
>> +
>> +/*
>> + * da_monitor_start_unaccounted - start monitoring without accounting
>> + *
>> + * Like da_monitor_start(), for a monitor that has been in its initial state
>> + * since an unknown time. The first transition is neither counted nor timed.
>> + */
>> +static inline void da_monitor_start_unaccounted(struct da_monitor *da_mon)
>> +{
>> +	__da_monitor_start(da_mon, model_get_initial_state());
>>   }
>>   
>>   /*
>> @@ -276,6 +293,11 @@ static inline void da_monitor_reset_state_all(void)
>>    */
>>   static inline int da_monitor_init(void)
>>   {
>> +	int retval = rv_edge_stats_create(rv_this.root_d);
>> +
>> +	if (retval)
>> +		return retval;
>> +
>>   	da_monitor_reset_state_all();
>>   	return 0;
>>   }
>> @@ -287,6 +309,7 @@ static inline void da_monitor_destroy(void)
>>   {
>>   	da_monitor_reset_all();
>>   	da_monitor_sync_hook();
>> +	rv_edge_stats_remove();
>>   }
>>   
>>   #ifndef da_implicit_guard
>> @@ -689,9 +712,11 @@ static inline void da_trace_error(struct da_monitor
>> *da_mon,
>>   static inline bool da_event(struct da_monitor *da_mon, enum events event,
>> da_id_type id)
>>   {
>>   	enum states curr_state, next_state;
>> +	da_state_t old;
>>   
>> -	curr_state = READ_ONCE(da_mon->curr_state);
>> +	old = READ_ONCE(da_mon->curr_state);
>>   	for (int i = 0; i < MAX_DA_RETRY_RACING_EVENTS; i++) {
>> +		curr_state = da_state_of(old);
>>   		next_state = model_get_next_state(curr_state, event);
>>   		if (next_state == INVALID_STATE) {
>>   			react(curr_state, event);
>> @@ -699,7 +724,8 @@ static inline bool da_event(struct da_monitor *da_mon,
>> enum events event, da_id_
>>   				       model_get_event_name(event), id);
>>   			return false;
>>   		}
>> -		if (likely(try_cmpxchg(&da_mon->curr_state, &curr_state,
>> next_state))) {
>> +		if (likely(da_state_try_commit(&da_mon->curr_state, &old,
>> +					       next_state, event))) {
>>   			if (!da_monitor_event_hook(da_mon, curr_state, event,
>> next_state, id))
>>   				return false;
>>   			da_trace_event(da_mon,
>> model_get_state_name(curr_state),
>> @@ -752,7 +778,7 @@ static inline bool __da_handle_start_run_event(struct
>> da_monitor *da_mon,
>>   	if (!da_monitor_enabled())
>>   		return 0;
>>   	if (unlikely(!da_monitoring(da_mon)))
>> -		da_monitor_start(da_mon);
>> +		da_monitor_start_unaccounted(da_mon);
>>   
>>   	__da_handle_event_common(da_mon, event, id);
>>   
>> diff --git a/include/rv/edge_stat.h b/include/rv/edge_stat.h
>> index 8b99e8520e1e..16c28aedabdd 100644
>> --- a/include/rv/edge_stat.h
>> +++ b/include/rv/edge_stat.h
>> @@ -145,7 +145,10 @@ static void rv_edge_stats_remove(void)
>>   	rv_this_stats_file = NULL;
>>   }
>>   
>> -/* A zero timestamp marks resets, which can run on a different CPU. */
>> +/*
>> + * A zero timestamp marks an unknown entry time: resets can run on a
>> different
>> + * CPU, and da_handle_start_run_event() starts in a state entered earlier.
>> + */
>>   #define da_state_entered(s)	da_state_pack((s), local_clock())
>>   
>>   static __always_inline void
>> diff --git a/include/rv/ha_monitor.h b/include/rv/ha_monitor.h
>> index 6e1c7fe5449a..78d1bb80aefd 100644
>> --- a/include/rv/ha_monitor.h
>> +++ b/include/rv/ha_monitor.h
>> @@ -312,7 +312,7 @@ static inline void __ha_monitor_timer_callback(struct
>> ha_monitor *ha_mon)
>>   	if (unlikely(READ_ONCE(ha_mon_destroying)))
>>   		return;
>>   	/* Ensure consistent curr_state if we race with da_monitor_reset */
>> -	curr_state = smp_load_acquire(&ha_mon->da_mon.curr_state);
>> +	curr_state = da_state_of(smp_load_acquire(&ha_mon-
>>> da_mon.curr_state));
>>   	if (unlikely(!da_monitor_handling_event(&ha_mon->da_mon)))
>>   		return;
>>   
> 

