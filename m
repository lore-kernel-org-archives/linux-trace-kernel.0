Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010067.outbound.protection.outlook.com [52.101.56.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DEB189906;
	Sat, 20 Dec 2025 18:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766255545; cv=fail; b=utFLTBmCPn8GWcKEkFjfJ95Y2TpMiQ794YA7uDh4P+jpDPmzjXFhfbtHe/8TuYobQfDS3R0ajsWqiDvGdFQP7BWZu2Ak0cqAr4sKNzze9GdS34LfJrCaOP/76qlpvPfLUgt0yUcTyT7KDm7yuYDwaCjBDVjN39WpPevqfaIkZZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766255545; c=relaxed/simple;
	bh=jpYPp+RCoqs1jjvsEBQ5muXIA9T0igKji6GAPR/pTpI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DBwFD/Yq9IbaltLWEh8fMjk+4RxKBbjxE07dn0RYzWll+dmNswXiNWMvXGBE+MJKOlNYbaFaaIKTdoF/F9naMmd1BNUY4L12RL+dPz/z1hIhxom/JVb11Sv6ylRAhPQo5hI6yAXcGbu6H7P7cSrQPlEncGb7QxAP4RKG4eNWJZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3/ZiWhwa; arc=fail smtp.client-ip=52.101.56.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3/ZiWhwa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FB74Pvlo9ZR/0EMiYWc1d4+i6qQCYM1aHoQr/4kSAFLwpAGqKptesj7as7fqL91ipr3lhYyMZaz79d2rf+q9fZI+sYRPxXBnOHlQyn0dQtrys0A63koLuTQbH6eT3ezRkPetrOh4n5N09nJLSRTrmC/GmNLgL1mQ6G4qnjBeQvtIohUG9Qoiz7Q+B1dP/JslTxAoWC5foGysp6Ro+IvIMR9OvwPQziEPVNAAdiGavtF8tLjpKk/iN1iZdmz/bG21YfKvT5lN6h0G4KB89t/ht4hdtbwwzoq4NWobUXA50ZKJy7rEsh8BPZkLCGfDskJ0o8Nz54/Tqt8cLDJglVuf5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QiUFsZte1Hb9yEKCTPF4jni55bS+aH0vbI8bD3RdUYw=;
 b=fj3kbtN0101jy+53yDccUFdAd8bU9gWXVoq/XcT3odBH0Hn6DmuHkIgy2jn0Q+ntoSB0teWewkGTFfPxG9YVLnazCdYt+b1o3Hmzm6zq0SSQqnFptU/8zxgzO3lM+3iQ9xhqmGUDoD8berehW7OhlatMKZQL8kpczVRWVtv16Q5KhRqYM26eArDzBbPRJORoMi1OoD7CLcW4ah8bTr9aeFikJIcdLEfZEzqUqixhNoG2X48w/VlcIQKujuJCMBvOGs5cYS8opfhK/zXNAuYtehw8W8Px+dicf03OBY3KTaJe90fNe/Z5qXDd5y6N59VXzpXLmwDNveq3RoyFbCYQWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QiUFsZte1Hb9yEKCTPF4jni55bS+aH0vbI8bD3RdUYw=;
 b=3/ZiWhwaHqS+trzoUmvyDcgs5yqF1z8ER7mvnl4j/SrBmyODu7PZ8cKiODgcFdllHSyIDrBBOMHXhou/Vtj+ssc+CYvDEWwizxVnquqEBCnOSShrb9+e9BdSt59F7JPU/uVhUIKcdsBGX3yk1yPYbOx32tbzcGcGIUR9rIxO9nc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7458.namprd12.prod.outlook.com (2603:10b6:a03:48d::13)
 by SN7PR12MB7252.namprd12.prod.outlook.com (2603:10b6:806:2ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Sat, 20 Dec
 2025 18:32:19 +0000
Received: from SJ0PR12MB7458.namprd12.prod.outlook.com
 ([fe80::83e7:e6cf:26ed:2f3d]) by SJ0PR12MB7458.namprd12.prod.outlook.com
 ([fe80::83e7:e6cf:26ed:2f3d%6]) with mapi id 15.20.9434.009; Sat, 20 Dec 2025
 18:32:19 +0000
Message-ID: <63453d94-6410-43fd-8676-dbb04e423b10@amd.com>
Date: Sun, 21 Dec 2025 00:02:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mm/khugepaged: remove unnecessary goto 'skip' label
To: Wei Yang <richard.weiyang@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20251216111139.95438-2-shivankg@amd.com>
 <20251216111139.95438-4-shivankg@amd.com>
 <20251217024818.ngoime34bxeatqij@master>
 <c7c1d62c-7d27-4b73-8173-0493adc66cfc@amd.com>
 <20251220003851.dzsafcxtlbgzwsm6@master>
Content-Language: en-US
From: "Garg, Shivank" <shivankg@amd.com>
In-Reply-To: <20251220003851.dzsafcxtlbgzwsm6@master>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0169.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1af::13) To SJ0PR12MB7458.namprd12.prod.outlook.com
 (2603:10b6:a03:48d::13)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7458:EE_|SN7PR12MB7252:EE_
X-MS-Office365-Filtering-Correlation-Id: 985fc228-7a75-479c-bc3b-08de3ff61b73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V2xjMGhZa0dKb1VHYUlBUnlUcTRLKzJEWXphUEMvRldLcFY2MWVVZkpRb3N0?=
 =?utf-8?B?MWEwSEt4VDA5THhqM2hvTWJQT2tmMHZFczRMZHlzVGx2UVpZWHhZYXM0NlBH?=
 =?utf-8?B?N2tpc2pMOGhWMngrTGFaNm1kUkdaTVg0eXROc0JBWGljSEFDckYwT2FZYkNH?=
 =?utf-8?B?Zjk3d0VRYmxCOWVBbDhML0N0K2k2T2NlZUVkeFNJSlZKQXRrN28vdERIWU1l?=
 =?utf-8?B?YnhjUDRkQk5vK1lkaEpvdVN6aDFScEZucnNyeGxGeWJmVElLaFE3UHZ5bEdG?=
 =?utf-8?B?ZjcrMVNjbUZsWklRbEJheEo3SWQ2SW1LYWlZWHMydGhNUjVXWnNic0crL2xW?=
 =?utf-8?B?Qkd3a0VESjdMbzdmOE8vM3d3aGNEUTBVSzhYRUdCL1VDZDBteTRQeDA4T3BU?=
 =?utf-8?B?ZHRjcnpxajdKRTV3SUdEQWhUV1ZkWnFXU0hITU9VZjlqSkZwek1lekhpYTIr?=
 =?utf-8?B?RGErT0R5ZVBtQk5KV0xqMFloOXphY2ZmaTdLL2pXWmRUeE5jNDN4N1lTWStV?=
 =?utf-8?B?NHVuR0d5RDVSdFlGNHZ6VHJtYUtSdEF1SzlwdFpiR2VEWkMzSlFyR09aT2R4?=
 =?utf-8?B?KzY5SytiOHhrN0pzYUp3dWhPWGE5WlR0WkQvMTlBNStuSkxNTEZYMUtmZEhl?=
 =?utf-8?B?ZE4xTXBFNG5Dc0FEZ21COXhuZW9vZkFKR2ZaRkMxeGJ5SnEya1YvamxCeWM5?=
 =?utf-8?B?ZUYxazlhY1I0bzVBY1kyWHIzQzAxNGdmQU9XMHF3OXZPdW1Ha2R2SXoxZDdZ?=
 =?utf-8?B?WnhDbzdTbmFiczMrKzFjaXo4ZU1XUDJWTzdkMjdIQVBSZkI4TWdkakI3Z0pL?=
 =?utf-8?B?Y0pqVXZ4NXVNN1FqNkcwNmRCVDdyZk1DQzgvUFJNQTJ4K1QrSzBac1NXemdN?=
 =?utf-8?B?NlZnb0VqUE8vRy91Q3B3dHhXVEJDQXNrQldDZjZvTTFqRzVsMTc0REJaYUlG?=
 =?utf-8?B?VXRXTklFdEpQT0I3YnFNNURCRS9oZlRCNzBhLzRRMHcvRCtoMFpWNEpQZW5X?=
 =?utf-8?B?Ui9SeFNPNVFIWWdIYkEwYWpPcGs5TVNZWkRTbXJNU08xcm5KY2xwN0hkRzRS?=
 =?utf-8?B?L0IxWUxnb2ZnV25GYXYzMEh3ZzIyM2F4NENhTkw1Y2RHaUFCT21vcWVLc0Iz?=
 =?utf-8?B?SkNyeTB5US8ydEZPQ0gzUm82ZU9yc203OVZCMzIycDhkZkh5Qmc0U3Z0TGds?=
 =?utf-8?B?SThLdGh3TTl4UU9qbGhBTjZVdnhTd1k1aW1Ham1IWEJlRkk2WUt2MDJiYlZZ?=
 =?utf-8?B?d3ArTnVDMVRsMTdKNDMxOHhZK1BQc3B3eTdreFEwS0tIK3lpWHMybHBTMWdh?=
 =?utf-8?B?Ky9qRkMzWWZnZFcydkpsOUJsRkhQS3o2aFYvbFFIQUNKdC9DRks0UzFjR291?=
 =?utf-8?B?REtQOHhaRVVneFNFU1c4RUVMaVlZOXZ2cGVpMjRvRVVqMHlsK3dJNzQrSTla?=
 =?utf-8?B?TXpnYmdLRUVzUjBETE1ZMGhUclVBb0RxRVVLNWZNNURibHRvL3FXNHZ1QTRH?=
 =?utf-8?B?UkQ0YmpPRkRkb25WaVZFNE5uck5wOTBqTjVvN244ckRnb1JUZmh2UG9EMW1R?=
 =?utf-8?B?b2I1TFhQRi8wT2hjUTVYR0pPNENkMk1seDhVNFlIanBnbUY2MlcyYzlvcHpw?=
 =?utf-8?B?WlRFZnk1T2dQTEwvbFlDeWZBL043NzRURkFibjRlS0l0Skt1OEdDNVRmcHNI?=
 =?utf-8?B?dXZNc2pWMXhCVFlibGY1SmpPOFdCczJxTFc0WUpIY1orSnlkTTJpamlvVzFm?=
 =?utf-8?B?aFk3cXpaV1FsbUtHWGw2OUxMS25Sbi9FZGsyaXhIK05LWUlUL2swUG1oOVM4?=
 =?utf-8?B?ZnNXUFlZY2FETlQ1OWlZOXQydnZtdnRDV2xSZURvamRhRCt1ZzlLQVdGSmJx?=
 =?utf-8?B?UThHaXZKcFU5ME5xTTBRbkh4aFVObUVYR1pNVE1rZGg0Q0hYRXl2S3dCaytB?=
 =?utf-8?Q?Y/5eyAo/Twe55M2Ucy+D511rJD55Wung?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB7458.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHgvQlN5WkJpejNuWWVmekF0d3F4bGx2VTNRaEYyb0N4bjB5T0dhdGI2bFA5?=
 =?utf-8?B?SDF2S2s4aEdHbEpYRDVLY2VyZE1TdWpSNHRqN3NPbmdvakZzb1czVlQralF2?=
 =?utf-8?B?UGFzS1RjUWRKR1BXZWY0WkMrRUhtT0dGUFgvY3QvMGRQYVpBd3ZVMUUxWmFw?=
 =?utf-8?B?M0JNWWxTcWFkZ0NaeU9LTlg4ZHBiQWdPOWZEMThiaGNGa25ISlZxYlNLU2da?=
 =?utf-8?B?YVFKTnVNcFZkU2ZpWWdoWFh1S1pkckpKWWlRd24vSEQ1aDdKOFZHcG5yZllk?=
 =?utf-8?B?R3crdW1FTXFJSXhMUWF1WmhVMmpVZXhGY1RjSkVDcnNnVTZCR1N6S0h2QXYr?=
 =?utf-8?B?dEFXQThabE9pbUkveEpjRWw4UlJGQ1VaWHU1RFpUV0RqSzVrQkVxUm9BNXJm?=
 =?utf-8?B?dWRqaUFuNVdtWnJRRXpaSW5BeVRrWXpqMzZEYk9Wa0g5T3NDWHR5VWVpSHN5?=
 =?utf-8?B?OWsvdFYxNVpkVnIrWFJtcVFRakRSUklZTWdwbkxaQm1Fc1hTdlNhejJreWJF?=
 =?utf-8?B?cDc2NGkxbkFweTg0NVl3YkVuOEtBZzU1T2FuK1BYbE1EdHJPc2F5dU52bU5F?=
 =?utf-8?B?d3VycWxnb0hMOGtGSUN4aFBoeWhoMGljZUJuTjlGUkpWanBuSlJ5aHBSZFpW?=
 =?utf-8?B?WElyRFpBdll4TzBuVVlzaElqalFvUTJ6QTBXMmVaS3JrRExDQ0ZqdmtHRUF3?=
 =?utf-8?B?aXNFV00vUWVOc2xvdGNjZXAwWkJENXhrVjNlOWpkNzNMRm1zRjJOam1sMXhL?=
 =?utf-8?B?ZnB1VVdVWWpyS0U1akR4ZENCRVk4Mi9TYzhidHJKejdiL0F5MzNhMUtic2FN?=
 =?utf-8?B?ODdMOTdTNlZWUWdxWVp1TzFaTXJ0U1AzM1oyTzJLMFRBT1hxVnRwU1BRMG1D?=
 =?utf-8?B?dk8veDR4K05vaDVuUzdaMFF1MVc4bUdFd2gzYXkycU1HNnN3Y3MvRWhFZHh6?=
 =?utf-8?B?aFFYbURnRGZ5ejNsSE54NXU5bm50MzZoVFkzU0Z0QThxRVM3V013V1kvRDVY?=
 =?utf-8?B?d3pmSW0wN0J3VDhGd3o2cmREM2IvYzZuK2ZWQ3ZObTVNZFVRWUlHUTJQdXpL?=
 =?utf-8?B?L3drNjlUTUVGc05MQW5ycUFJZys3YXR3Vkp6enE3TXpmSXBZanZMTHhyT3hH?=
 =?utf-8?B?UTl0WXpyTUZZenFMQ0dwUEtvMlZNN1czd2YwaWZsaW9RSjFXbUZERmhOa1M5?=
 =?utf-8?B?VVFiTTFvVDR1elhLSHd6RkxxUE12Q3JnNHFERkQyS0w0bFIrR0t6Rkh1QWFT?=
 =?utf-8?B?OHk5QjdsYjNKanhORWxUWmRDaHM4cnMzYzRISXhnb3l0WEtRQnMzeldsL2Iy?=
 =?utf-8?B?a3ZoUlhLM0dZV0U1VDl5VEpMSVpUVGhZS2tPUnVGcjB2aWZyRkphd3hrUUVX?=
 =?utf-8?B?YklXOHo0OFdhVjFvQjYwcWRQUTFXSGRaejFOcHhTZ1R2dURMZm1PN3R3Ym5R?=
 =?utf-8?B?Y3Irc2dNcGFCbGpaeGlpVWZNT3BieGdlZVlrMHhNRnNhbzhsNWppRXF5VGNI?=
 =?utf-8?B?NGNReEp2R0I4b2JrdEpQUDN0YXBMbDBnZWNrcms3dk1MR3RMV0dtTzZxQ2lJ?=
 =?utf-8?B?c2tVL2E5c0g3SUlTZU9XdkY5TEI4MWcyL0tOY1c3aTlweWg0QjdZbTI4ZHpJ?=
 =?utf-8?B?aDNFV29pWUlaUitURCtNMUsvQ1dKUlk3TjBHdDAvV2ExejdKRWFDZ0p0Zms4?=
 =?utf-8?B?cnV2QkJ1aERrYlFlbG80U05aOGxaTjF6Rk8wOUIycjUyZUd1cWYybHREMUZQ?=
 =?utf-8?B?R3lzTWNEWE9uSHJhR2pxUVA0TzNCSUpPSWQzNU1FeU1sL3FGdHZHeTJtZk1U?=
 =?utf-8?B?bldYNWJxYVpyL1cxUmJEUTVaZjlpZU1ER0dUbVNKb3dNNHNMNEhpNEZnTGVJ?=
 =?utf-8?B?ZWlYaElGL1ZlNmFxdHo5UVJkZHpWeWt2bDkvUGxNMldDUi8yeEpzZVZySldJ?=
 =?utf-8?B?VUxZN25CY1JYQWVZL0UxeC9hM29ZcGZKdUR3eGp2Q2tVTUlyS1FoYVYvMHZw?=
 =?utf-8?B?RkllSHFGYnFEbnNsMXBaWW9GbnBnYXozeUpEOGh6cWlPNHY3RGpvOHJ6SWhS?=
 =?utf-8?B?Y2M2TThKdjZ6TXo1RFZ4WWdoSW9rQVRmVzYrTVQyeHpaQTUwYXdSd1p5THgy?=
 =?utf-8?B?Mlg4em5rZVM0cVIxelcxUEwxTFZuaDgzM0tIR05jYWdFRzFqVnorN0xDNXFv?=
 =?utf-8?B?ZnIzVDdLaWlCc0M0VGZ6U0k4Q2NtZUhzc1E3RUVDeGZ0bDkxLzZUQUFnR2Ja?=
 =?utf-8?B?NVY3TjFVVkJTN3AvY3F5aWNGZEUzOHF0cFlySmRjQWdHZnYvaVRaVi9WNDFn?=
 =?utf-8?B?dGVBSEdzQ3k2eDB4YXRESklSc2xRTnpnUFk2K09lQ0N2cGR0VGpDdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 985fc228-7a75-479c-bc3b-08de3ff61b73
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7458.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2025 18:32:19.1451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uwlgo2DmZ1jtHpk0HvHBaiLJ9yOh12ZVLl680amyL7rUf2zmXjOdgYk+zP3gaJrMxRlS1VOBaJLzokK7+4tNrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7252



On 12/20/2025 6:08 AM, Wei Yang wrote:
> On Fri, Dec 19, 2025 at 02:54:40PM +0530, Garg, Shivank wrote:
>>
>>
>> On 12/17/2025 8:18 AM, Wei Yang wrote:
>>> On Tue, Dec 16, 2025 at 11:11:38AM +0000, Shivank Garg wrote:
>>>> Replace 'goto skip' with actual logic for better code readability.
>>>>
>>>> No functional change.
>>>>
>>>> Signed-off-by: Shivank Garg <shivankg@amd.com>
>>>> ---
>>>> mm/khugepaged.c | 7 ++++---
>>>> 1 file changed, 4 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>>> index 6c8c35d3e0c9..107146f012b1 100644
>>>> --- a/mm/khugepaged.c
>>>> +++ b/mm/khugepaged.c
>>>> @@ -2442,14 +2442,15 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
>>>> 			break;
>>>> 		}
>>>> 		if (!thp_vma_allowable_order(vma, vma->vm_flags, TVA_KHUGEPAGED, PMD_ORDER)) {
>>>> -skip:
>>>> 			progress++;
>>>> 			continue;
>>>> 		}
>>>> 		hstart = round_up(vma->vm_start, HPAGE_PMD_SIZE);
>>>> 		hend = round_down(vma->vm_end, HPAGE_PMD_SIZE);
>>>> -		if (khugepaged_scan.address > hend)
>>>> -			goto skip;
>>>> +		if (khugepaged_scan.address > hend) {
>>>> +			progress++;
>>>> +			continue;
>>>> +		}
>>>
>>> Hi, Shivank
>>>
>>> The change here looks good, while I come up with an question.
>>>
>>> The @progress here seems record two things:
>>>
>>>   * number of pages scaned
>>>   * number of vma skipped
>>>
>> Three things: number of mm. It's incremented 1 for whole khugepaged_scan_mm_slot().
>>
> 
> Agree.
> 
>>
>>> While in very rare case, we may miss to count the second case.
>>>
>>> For example, we have following vmas in a process:
>>>
>>>      vma1             vma2
>>>     +----------------+------------+
>>>     |2M              |1M          |
>>>     +----------------+------------+
>>>
>>> Let's assume vma1 is exactly HPAGE_PMD_SIZE and also HPAGE_PMD_SIZE aligned.
>>> But vma2 is only half of HPAGE_PMD_SIZE.
>>>
>>> When scan finish vma1 and start on vma2, we would have hstart = hend =
>>> address. So we continue here but would not do real scan, since address == hend.
>>>
>>> I am thinking whether this could handle it:
>>>
>>> 		if (khugepaged_scan.address > hend || hend <= hstart) {
>>> 			progress++;
>>> 			continue;
>>> 		}
>>>
>>> Do you thinks I am correct on this?
>>
>> I think you're correct.
>> IIUC, @progress acts as rate limiter here.
>>
>> It is increasing +1 for whole, and then increases by +1 per VMA (if skipped),
>> or by +HPAGE_PMD_NR (if actually scanned).
>>
>> So, progress ensuring the hugepaged_do_scan run only until (progress >= pages)
>> at which point it yields and sleeps (wait_event_freezable).
>>
>> Without your suggested fix, if a process contains a large number of small VMAs (where
>> round_up hstart >= round_down(hend), it will unfairly consume more CPU cycles before
>> yielding compared to a process with fewer or aligned VMAs.
> 
> You are right. While I am not sure it exists in reality, but in theory it
> could be.
> 
>>
>> I think your suggestion is ensuring fairness by charging 'progress' count correctly.
>>
> 
> Thanks for your confirmation. Would you mind add a cleanup in next version, or
> you prefer me to send it :-)

Sure, I'll add this fix patch in the next version.

Thanks,
Shivank
