Received: from mx0a-007b0c01.pphosted.com (mx0a-007b0c01.pphosted.com [205.220.165.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB8A14D29B;
	Thu, 10 Apr 2025 20:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744317086; cv=fail; b=IWzw0mU3RcgwsNeDAi13aobOTdcVeajdLg72fgYWxUZ6bV7YbKjDtfmG6HUQe36TtJybuVynQ7uHaTo+uhI/9oyyuWSqPDdqQc+yQJlyLEiGr0txfaHSqB0Zibs0A+ipHZroWPHncxiEkr8A5iVUqSyzmQxx6L1rgicbpfwwGNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744317086; c=relaxed/simple;
	bh=7y/Y+D5bHeRQXKYhXbtQGfJJoF330+0ZHgQIjQhqjPk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JfXnZVoJqjEhdogO97cG5u07xeIfWM54E7xCOcZcJjeRHVWiihpCYq0UfsV/zNhiShRQSynOa4w9w9IKnEjrCY3K2938SC+SE9Wih0uPrS8t7Qmsr+jghQun5EIeqh4u8NKvklp/cJNtaESxo3XtmAMnPdihZ6HGz+oHH6hNa4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.wisc.edu; spf=pass smtp.mailfrom=cs.wisc.edu; dkim=pass (2048-bit key) header.d=cs.wisc.edu header.i=@cs.wisc.edu header.b=aLoJ5BXw; arc=fail smtp.client-ip=205.220.165.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.wisc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.wisc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.wisc.edu header.i=@cs.wisc.edu header.b="aLoJ5BXw"
Received: from pps.filterd (m0316037.ppops.net [127.0.0.1])
	by mx0a-007b0c01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53AJP5kS023398;
	Thu, 10 Apr 2025 15:31:18 -0500
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazlp17012034.outbound.protection.outlook.com [40.93.6.34])
	by mx0a-007b0c01.pphosted.com (PPS) with ESMTPS id 45w7erkrva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 15:31:18 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ihgvp5w8WmVq6AqVmsypTJCzSobwpHOroO7nmoAL+HmgxQDp3qtfa7g7o8wvfOeUova+Xq0/0TTGRqA1bqGw1TSB0oIqF4QDij1SOt5whftf+qA2vPPC+Rg6hmf30QSWL9tMv8XC3EAiQ0DH8OK2JDDKSgJXPFdq6lWiKI3BfsAqyVyJWGTeC0BqKqpoUyLqZXrVHhTcZCPgh4nCv3iv9SlHdr6zaG99UDawo18EBK0ngzjJwWI3V583spASWiJYHosJvuqXZn8MNiqdJOY07kkO4lvFVom/++iFaG744QHdh0H5UEBWKwmqIOYHoBaYmeGj0A2H9dbx+oTIlfgdRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfUJqvZSkbkjngS0aD9rth2LlUIJfLmOgDlN+5l/JBQ=;
 b=adJ2PJ2tbp6Kf1a0U9dVhskNGZ56P0zx4Ypj0MW24MGNwfp2QF8dzzBT1mP4eICcbzb1j6zcIDiIeOeivZ6E1l2jN5LY+kX/SXDNwwP9J7pJv6wBWjQ1dcyxoi9cTGXLzN4JFCAAlV1iKPgB5VaSqc7tskWPFQtneKkiEhcEKC4u85ZE7M+XYjspQdx5o+87WxWRN3y1ooJhdK/8jthP8QQM4xFDAus2OI3sLjRoCUC6KqdKLZXiAAdMe5GEbUb+Gp7rJ1nPcBsb0NDSyHtP856mNb9vgc2rLWLY6iZnoaUgoqqPqzD9YaKK+fR+mHzIjppZ4Ra5m2uVXUzyvR0pzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cs.wisc.edu; dmarc=pass action=none header.from=cs.wisc.edu;
 dkim=pass header.d=cs.wisc.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.wisc.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfUJqvZSkbkjngS0aD9rth2LlUIJfLmOgDlN+5l/JBQ=;
 b=aLoJ5BXwMj8sMyCI626124PXWLZPxNwuRTQGQZSAtYtaJGi1TzVwWzDbNeWdXPh689n+8F4HGmx0X8LFlxSm+ERzbkiEvA2lUDqe/Kp45AnEBIgdzl/Vb0PrvOtqukEQK54BNfcLwhqEU7wOUUG6DSH+sCO+M4RtZZcXjBxKWI5Hcl1jh6Kt/zQBhFPrlYaA2nbfPY/pqvm7HERKmkHOq4wYUW5RsSAXKb1u3YSMPNKjrFlvC6G2VTo0NqBtdkTzrcmRfNfKTzz+6/YvElQ3m7urhdf2laCL6D8ZjnXXa78RQiOhxpv+sHKeBBctggVb45rB28YhNypUJCXwgCE21g==
Received: from DS7PR06MB6808.namprd06.prod.outlook.com (2603:10b6:5:2d2::10)
 by CO1PR06MB10675.namprd06.prod.outlook.com (2603:10b6:303:273::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.43; Thu, 10 Apr
 2025 20:31:16 +0000
Received: from DS7PR06MB6808.namprd06.prod.outlook.com
 ([fe80::76b2:e1c8:9a15:7a1c]) by DS7PR06MB6808.namprd06.prod.outlook.com
 ([fe80::76b2:e1c8:9a15:7a1c%5]) with mapi id 15.20.8632.017; Thu, 10 Apr 2025
 20:31:16 +0000
Message-ID: <d749ab33-706f-4cc3-8124-fc71e6f8fedd@cs.wisc.edu>
Date: Thu, 10 Apr 2025 15:31:12 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Interface for enabling context tracking
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <9e2ac1e3-d07d-4f17-970e-6b7a5248a5bb@cs.wisc.edu>
 <20250410150555.7797d195@gandalf.local.home>
Content-Language: en-US
From: Junxuan Liao <ljx@cs.wisc.edu>
In-Reply-To: <20250410150555.7797d195@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:208:23a::10) To DS7PR06MB6808.namprd06.prod.outlook.com
 (2603:10b6:5:2d2::10)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR06MB6808:EE_|CO1PR06MB10675:EE_
X-MS-Office365-Filtering-Correlation-Id: 860c4e0d-8083-4917-62da-08dd786ea445
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|41320700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cVBpSmwwTHNxMWRPczFxaHFURUpGb3dKSytwNC9qWHlJSGROK2EvdUovTkhG?=
 =?utf-8?B?MGRjd2lURlFQMlV2WTc3OHpqNzhCOFNQVFVieHhFVUVMTVZobXFaOWVUUjMr?=
 =?utf-8?B?R3NUVlFyTCs3emhNMjZiV0g3YXNlM3J2QXJNcDFrdEZyb3AxanNkTnNycnp1?=
 =?utf-8?B?ZDg4UEdUbFpaY3ZVblpVemNTeWZCMk84MFlva2pPZnh3dnhuaUVJVDBCWHhr?=
 =?utf-8?B?MzJndmtZZEg3S1ZEaGoyUFQvNmtyRVE2S2dRRmtUMVBKd2RUV3NqSnFMSlRm?=
 =?utf-8?B?UURjbysxaFk2R3FXaE1Va3k5aG1hOGFzVzJMLzJlQ3M1RlpZM1VCWjYyOG5P?=
 =?utf-8?B?Umt6V2s2aVpYbjRxa2hudjYrcVVyY1VXU2I2WlJqaU9va3ZnaGMzSTE3enFW?=
 =?utf-8?B?V2p3dTRYNnNGUWJUSnYyR1JmZ3lKbVNSUndhc1I3L3BsMk1SYUVIU0x4MnFZ?=
 =?utf-8?B?MkRpdnlWSXorS1VZL0sxbkhSZ0lsMFdaL0FqUlMwR1J1M21VYm50NmhtUWhW?=
 =?utf-8?B?djhSWkN0Rmh5c3haa2F2eEh5bk50Z3JVbVBSUktJSndhaFd1TWxjMGp5QndH?=
 =?utf-8?B?OXhsVmJnajM3aVlrcVJwVjQzeHF4YW9TTjNlNkdvUXV4aTlaSlRmYjlQTSt1?=
 =?utf-8?B?TktSSTZ0cDBzVXBoMjI4UHp5Q01vWTcvczNTMkZ0RjczcXIvdnVKTWtieTIy?=
 =?utf-8?B?RWgzejhGYk43VUJKL0tYbC9xVm9ETWNMaWRTQXozZXdOZGFxMWpHUXUrVFVP?=
 =?utf-8?B?TUphRS9XMTF6UUlvMm5BMFFsWEJUZHRUbTBPa1BYUHA5SEY4TWt0cXRlOWdP?=
 =?utf-8?B?ZWJqTXJjRFMyVHY1N0JnUFhESm15T3IyMmxtdkozRjJpMGdyOU1ZdUROZUdk?=
 =?utf-8?B?ZlJTZTZEaGNPbWpSb2I5Z1laNW80ci9tRVRONUV5M3pKbkxNWTBFVnI5amwr?=
 =?utf-8?B?ZEw4Q2lDMm5JTERZRHVydXpOTHZMbndaV3Uwc2ZZVkQrWUVHTFg2ck1aT00y?=
 =?utf-8?B?ZWdXajZFUG5UME13R1d4TXBCNjZGQkdrbTVQUzBPcElhU2xUWGM2ZDl0SCtT?=
 =?utf-8?B?RWxLblRiMEppMFdtRUgzTTY5dGxST1JtODZiQWp1NVRTaTJ6WXp5VmJiOHJC?=
 =?utf-8?B?UEZ1Y2dhNDB6WGRCb2dlS1UvN0NCTkJQYjE2bFVtaGZlY2duby9jaThJa21h?=
 =?utf-8?B?d2dHLzYwN1cyamJzY0M2eTk4SFZTLy84YTJNMkZDZ2xKTm9ka0JNZTFmOGFD?=
 =?utf-8?B?T2lhaDJvL1F5bXZZZmdTK0JRMkNyOG5tdjBZTi9MSUk5L0lUaXJIYTB5Nkw4?=
 =?utf-8?B?RWRUamhlcFd3djk3bDFMSWVVcGxKK1pGYWNxcUprYlNESXd0WjJsVWpOYlZh?=
 =?utf-8?B?aVBlOGZFcWZCdzd6bkY0by9yVnlQWmQ5eG50WWEvVTVrcnVzeDlCdjlxbXpB?=
 =?utf-8?B?R3JKT3FsbjAwVEVLM2Y0NmZtSXJ2Rkg3S0h1VFRPNDlPY3RxY0p2cXhyMjlL?=
 =?utf-8?B?dTd2WnJJOFJmZS93ZDl4N3N5WldnUWxqZHM1VFkxWFlvRkJ5QVBhVDJEdDhB?=
 =?utf-8?B?M3EwM3VLUUJHNmdPSHNDakJDcmhweXpYVy80ajl1WGlxSGZ1THQzZGorUmF5?=
 =?utf-8?B?MHU3Ry8xRlNzM0xIMWIyZEZvR21RczdkelJmWmNBOU9zV0dFNlgxZzlxaXBy?=
 =?utf-8?B?ZUtwWlVJdkNVc2Z0L2J2WWdma0tOYmQrTldadmg2Q0YvQkovOXVXTm1DMEZC?=
 =?utf-8?B?dWR1bUJIOS9mcFhyZmxEQXdyTlloTS9KWHo3eUd4Y1dBblVjejNQWld0M3dJ?=
 =?utf-8?B?SmFwTzN3Nk9DNGNlMm5nekx0QXdLR0VzSHpKcWtFSjN4S2FvQzhUUS9QalRq?=
 =?utf-8?B?MEdCa1V6blVocHZZNE12amxQQjQvRDNCdDNSZmJtOTdPK1VBZUNvQS9aZ09N?=
 =?utf-8?Q?uZrjVZPHG/A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR06MB6808.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(41320700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2tlQkN0Q1JPMHplb3dTR0Z5aUJGQVNnY29mQ2tNT1paaDUrTlpIZkY2Vjdx?=
 =?utf-8?B?RUdrZHJUWHJjS00vMkZBdkRCbzgxZ2FyVFc1R3piRzlVVGM2cnlibjYvVHRD?=
 =?utf-8?B?dTN5Ym0rYjN0bkF5VjM4OEhQcy93VEl4c3VvMmlzR0RmU2ZRQjZtL3NqdlZO?=
 =?utf-8?B?bEJ4WjEreThpWUJ4SUpVYUxJV2pCTGh2anUwd1RDVytmTnpFL3dvQ25vUFRH?=
 =?utf-8?B?RDJxYlRzYWMydW9sa2k5blJOTFRkTEpya1NiejVQRk9aUi8yK0xQd1hlQUND?=
 =?utf-8?B?dklkSGtWc0F3Y0RvejlONlp5b0xFVnNvejJybm0zdUJWbUdxcGdnQU5sQkpI?=
 =?utf-8?B?SXlhc003U0xheFg5VjJ1NmxBL0M1citNRGttcDV2bSs5c21QRlRZd1BCbXV6?=
 =?utf-8?B?N2Q3N2QweUJLZ2lWM3U4Y0x5MGtrT2xJZTJNcWN4S1h2NEN2eFZHdjlFYm5m?=
 =?utf-8?B?WVhaaTlSdUtyeU9zaGFwZmxMb0NlQ1JmTk1pbVJPRkFZVVpXY21BS2kvZjk2?=
 =?utf-8?B?Wk1WNGpyYzM3MWRmYmllV0tzd2FVMUl5VTlLODhZSFhVM3ZIakloaUNSZ1FS?=
 =?utf-8?B?ckt2OUViL1hWcFY4bFd1MXc5S0Vlc0JkN2trd1VSVE9FT1lmSmpYU2VlRzMw?=
 =?utf-8?B?b081a01vNmQyVU4wQ1duQzF6b0VjbXp3eHA5ZWJScVpzb1JjVStDOU5qL3Yx?=
 =?utf-8?B?NXFQM2lnZk55TW9jWldnRWIyZ2E3YVYzNnpHblViTzlVcW8rRERpQTE5UDBi?=
 =?utf-8?B?TnhSd0FGNTJNaXFuQWpCYytpSDJUUWZDSDdaOGFxMTk2V1BuaHZydm5nMy9Z?=
 =?utf-8?B?dkJEdUM2R2pOWjF0czhuUW9HNWRva0JwMDVPb1hTbXFPeXdWNVdwNkYvSWRQ?=
 =?utf-8?B?WGN4U0RFZ0JRT3JKbk5EWno4UThxMytEbjA3a0N2OGcxc1NHOUV6YjIvWWFG?=
 =?utf-8?B?eDBtY245SDloQWIxcGZUZEZMalYrL2VFVnZ1UWhDRWpTdmllM0lhUnN5T0Zw?=
 =?utf-8?B?WVZsV0RibHhvS3RpTHJsRTRmdzJRVlhUSCtvOTA5ZkR3S25hcHVFcE5XRklR?=
 =?utf-8?B?NHdJVEtnWXNOWFBTcDhldVJKWlIvVExTUXpINGNQcTlrUW8yN2d4Z1IvVG9Z?=
 =?utf-8?B?TDkzQ3FTTG9aUmNZS0piSUdrUGkwM3RudUZnUXdQMDlCOW9zV2hUOGVWd2pI?=
 =?utf-8?B?Qlo3azNsY0pKRnlZTWNMMzM5WFJQalNZSG1LcG1MVXhvRmhkVElPZjVFQ2l5?=
 =?utf-8?B?b0RJTWNkZ1ZwUExWUVBwZ0pUNkNOR2ZneVMrUFZwc0RFZ2k4eEp4TFVaVkZi?=
 =?utf-8?B?OWlpVUZmdmdUb044ejBqeDNVeGRGOFk5YVp3bFg5NlZxdnRndW5NSExpanZI?=
 =?utf-8?B?UEtyWUFTMUtmQi9iSTJSZWU1cjVpemNMUWhJOXVqM0Y1aGZTS0N2dWVQRkVx?=
 =?utf-8?B?UjFrb1AvNWZaVm5YblFQcm9aaFRiaDdKZlNYR3JncnBWWUtKZnlzSU9MN3Uv?=
 =?utf-8?B?bjhDK3J1T2NNYW1nYUljVDkxaUZzTHRWdFhockxKSUJxRUs4akQ2emxpR2l3?=
 =?utf-8?B?Zm0vSnZQdnowM1FsWTJTUFExa3ZGTlU3bnJBaGs1MFBBL09oY1p1b1dieVlR?=
 =?utf-8?B?VnVpby8rN2VSZTdnaDR3aWxBOE9iK0JDNkpCeTUxSzd5OVVnSjJvR1lGZU9u?=
 =?utf-8?B?UDJ4QW1LV0NyS096cnprNzBIelNSV2t6VGdpN1BsOVFtb0UwSWVTS29yZmxn?=
 =?utf-8?B?RlBSUEVBMXVUVW5XZUgxS201ZW5Sc00rYUl0eXg5cDROdlA2cGczWGw0VWwr?=
 =?utf-8?B?UEU2dVFlRTZ1SzFjWHQ4clFzcmlJSlpidllJMFN2QXNidHpTeG45dmFPcEpU?=
 =?utf-8?B?dVF6d09mTFlSSnFxN0ZTQlJGWWRkdEZsYkZkRU4vVWRmSTNVb25TTUxMZlJw?=
 =?utf-8?B?RW1hNUFCN2ZKdU9ITmU2OUU3YW5JeG1iWkRHYzZkd2d0NXZscnFqdUQ4VUUr?=
 =?utf-8?B?TWtsemFrTVhDSkF1aWZkZ214NVpwcmFJUzFMZnZwYXZDNzlneVVxNitBSUFT?=
 =?utf-8?B?SEJOSTM1YzlKRnBYcFlGWXFBcmRJRnRQQlh6M3hhcFpYYnB4YmhkMytsVlo2?=
 =?utf-8?Q?yWGk=3D?=
X-OriginatorOrg: cs.wisc.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 860c4e0d-8083-4917-62da-08dd786ea445
X-MS-Exchange-CrossTenant-AuthSource: DS7PR06MB6808.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 20:31:15.6551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2ca68321-0eda-4908-88b2-424a8cb4b0f9
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BSZs7rRO7W9NEpmE3Abdry0BwB69Ez/VHUByDThCJCSOZjpwsO+pPtBRQXZtCgNz+K5Tdj/FmBDWyyGQ7+AJsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR06MB10675
X-Proofpoint-ORIG-GUID: ezrZ9HotJQcsw2-ltk8uMKl6xDw9-znR
X-Proofpoint-GUID: ezrZ9HotJQcsw2-ltk8uMKl6xDw9-znR
X-Authority-Analysis: v=2.4 cv=KJFaDEFo c=1 sm=1 tr=0 ts=67f82a96 cx=c_pps a=jgLrbg7RBTw9j6qPRKhXvw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=3-xYBkHg-QkA:10 a=wlpZQ0607Aa1vfJP9VsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_06,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 adultscore=0 bulkscore=0 mlxlogscore=602 phishscore=0
 impostorscore=0 mlxscore=0 suspectscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504100149

On 4/10/25 2:05 PM, Steven Rostedt wrote:

> I think the best thing to do is to add trace events in all areas that enter
> and exit the kernel normally (where noinstr is turned off). There's already
> one for page faults on entry. It's been on my todo list to add one for page
> fault exit (as I do care for how long they last.

I agree. That's indeed better.

> I believe the irq vectors also have entry and exits trace events.
> 
> What else is missing?

That's everything as far as I know.

Thanks,
Junxuan



