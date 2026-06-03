Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013067.outbound.protection.outlook.com [52.101.72.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF72042E017;
	Wed,  3 Jun 2026 09:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.67
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780477205; cv=fail; b=Yjot8cL7WBu0MtDRtJxup3s1ruSOgZs/F2nLyWQnVxlRGJ3GdLwVpeAHn6vsVabK+MpgS+3kcc1TlVu+MZnquz3EUvS06sZn8n8PCJMrk4FKlgkdvk1k0Bhw6QPmZS/360rKPbueH1Cgxj0sFNWMqMN/ySUnfoJVXZEc4uGF7co=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780477205; c=relaxed/simple;
	bh=XHrPero2zBgfOzZAF9o/NyIhkZmzinCoXetJ6xNYyFk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qmPOVC4sWiABv/pSL4K9cEuiKxssxEn8qQPHpkEXB/iB0a6uodudn1h8kjS1sZntS3RT/2MnnwXyZnPeJ/3WuvG9eowVt9lxd/VwOb32i/wcuMGZarpNbCiH0P3lK0w+Y/AoLAE7aLINzQavWGqgyz1bsMuAMsI1k4wB9J1i2KA=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=rev1ga8g; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=rev1ga8g; arc=fail smtp.client-ip=52.101.72.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rev1ga8g";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rev1ga8g"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=dXrxCYclDJHSitK8Yd1gUm03GkSB+aK8ZDfWxWYQndR/xoB1PdjQt2gaA7Z6ogQLFMSD5bkCx81QP1o0ZaYdlVYIjEVCmr9FW8g7LungKju31cSY7mNWqUylShVixABCIgLbAhcJ/mo0MtnZkb55vEiE/xKUNKg5qckW1MwSDtjwAYVtNZgTDKjmPDve8PPIDqMF9xMvE6kAuWkNTGk5+1LbsUWlwjLmv9hj1mO5O2QUdSImC7nVrbV/GEk2VL8RejIm4MX1AnSV33O4tB+xBnuwufYomyhYWAYtYagGXxUpS6esj6jO+lzaoYo3ZwhxA3oeAtyVRCdFTkv3pMeu/Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6IicQCtcCk7kVw2DQcmAHZD9BLKGpYz2zKMJtqG+KbM=;
 b=siFkwuLbSUzVbFv7Dic4snJiShAimDZYNrSeSw4voJzcUOU7kAk49JQ4gSKatKdP8Xt815J/Rf2ZHjm7Hu+Qaf0wj1zjT6b7rwIdW2QHKZ6i91o+qvPbHy6moa1HNlCShnu+PNlMXO6aW9a2G3PQFxrbFR2ICvCS8kEMlPJ2btszXVV7qM3zvA44usVZZdi3o89ks5kalMAYduTINKiaP03XqPML3qX4xLc0007Tu45OKW+FpzJiRt/M7YEuSVP+teK4wjE/MM8wAGxBsTjArRWBcBfFxcjY4240IZGgkJ7tMJ8pjwMtSmUY4cVh/yUJpQYq9TWpnY5ZOT0IPLHgcA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=google.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6IicQCtcCk7kVw2DQcmAHZD9BLKGpYz2zKMJtqG+KbM=;
 b=rev1ga8goaf53SlpfiGGL+9uQL1FXmNOfCd+rq7YT/oCKBsz0LsptxCYWUqdw3ydVi0zTQes0vTRkGZArhniynE23Bw/U2l/EVfEeId7BMWol9Ha654AvG4v3HsZ4IDGTCkeK7YpYrjW+6GF6yGzYNS97OpNt1j0Z88I/f/OAUo=
Received: from DU6P191CA0037.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53f::16)
 by DU0PR08MB8089.eurprd08.prod.outlook.com (2603:10a6:10:3e8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 08:59:51 +0000
Received: from DU2PEPF00028D0D.eurprd03.prod.outlook.com
 (2603:10a6:10:53f:cafe::47) by DU6P191CA0037.outlook.office365.com
 (2603:10a6:10:53f::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 08:59:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D0D.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Wed, 3 Jun 2026 08:59:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MTQlsnzDlWWWmddOu3s21vWO4DeGxiLZYIgaDxAaA/tcbHSoh7lf1IrlQqbtxGuTqNPAssgBWYxFz/xRfT+ZJdjCDBFiAE/QCLp9eTuNajQg2NHl/jqnGqnb/CxT7HumB886QojPYkNz/K/rlUOJqgBmFmbT6T3/9WeCmlVZs3wvPi46dgNMh6SWnsxJMNm/fApc7rjaas5P1UzAn01VqO1ZKhP2142R8CrfZjaM//LpjV5ht2/v5wZMaLglkUmZ0qeNu4vHR3/asLjWIuT6fcB+X6gURTd5+XvWT7BQfl/+j+nytFiNzD0EMTS3Q4KM7J8C8TdA+5+SMZl2Zm0YmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6IicQCtcCk7kVw2DQcmAHZD9BLKGpYz2zKMJtqG+KbM=;
 b=dgCuL8j9CH+kWN2XWfaWeq4MYYqgCTMq+gsb0AicfHJkkZCLU5G71wXKUVJQK0Xq6TRYWral9MEfA237C7yZHc65QIYXYlvvcssUx8rUeVlPu9tIcFgMXaprcmuZHDsDI5XUCrPYTeKuTYWBpSpMGytqbbLqpQGewugWOzjHswdwYByHQ1uKgSCZgBgT6kd6oUg1oU7FtvXuFlES0ggtLn6NnID+3EyEdz+w1oumbxZ9kHPxlqFjEbEb2MqNxItkwtcWqErM3adPDGeRXS+cx+eKvc1743t/tujCxC8hcVA8nXpLAWqgIRzvslOydzzjmE8+VEubgK2qGp3gNaPZTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6IicQCtcCk7kVw2DQcmAHZD9BLKGpYz2zKMJtqG+KbM=;
 b=rev1ga8goaf53SlpfiGGL+9uQL1FXmNOfCd+rq7YT/oCKBsz0LsptxCYWUqdw3ydVi0zTQes0vTRkGZArhniynE23Bw/U2l/EVfEeId7BMWol9Ha654AvG4v3HsZ4IDGTCkeK7YpYrjW+6GF6yGzYNS97OpNt1j0Z88I/f/OAUo=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PAWPR08MB10975.eurprd08.prod.outlook.com (2603:10a6:102:46e::7)
 by AM9PR08MB6209.eurprd08.prod.outlook.com (2603:10a6:20b:283::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 08:58:46 +0000
Received: from PAWPR08MB10975.eurprd08.prod.outlook.com
 ([fe80::3c7a:9a64:14bc:ce15]) by PAWPR08MB10975.eurprd08.prod.outlook.com
 ([fe80::3c7a:9a64:14bc:ce15%7]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 08:58:46 +0000
Message-ID: <88cae738-18e9-4ed3-8414-506a1ad8fb18@arm.com>
Date: Wed, 3 Jun 2026 09:58:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/42] KVM: guest_memfd: Only prepare folios for
 private pages
To: Ackerley Tng <ackerleytng@google.com>, aik@amd.com,
 andrew.jones@linux.dev, binbin.wu@linux.intel.com, brauner@kernel.org,
 chao.p.peng@linux.intel.com, david@kernel.org, ira.weiny@intel.com,
 jmattson@google.com, jthoughton@google.com, michael.roth@amd.com,
 oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com,
 rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com,
 steven.price@arm.com, tabba@google.com, willy@infradead.org,
 wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com,
 pratyush@kernel.org, aneesh.kumar@kernel.org, liam@infradead.org,
 Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
 <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>,
 Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>,
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
 Youngjun Park <youngjun.park@lge.com>, Qi Zheng <qi.zheng@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-coco@lists.linux.dev
References: <20260522-gmem-inplace-conversion-v7-0-2f0fae496530@google.com>
 <20260522-gmem-inplace-conversion-v7-7-2f0fae496530@google.com>
 <d01cf1ec-b85d-4af6-9810-8107c0e2a4ec@arm.com>
 <144bbb9f-39a2-4c90-8903-51521e022da0@arm.com>
 <CAEvNRgE1dCVAxJWd_hyFa8N=m9JLfn97ip9tAmvHxspWJ50oGg@mail.gmail.com>
Content-Language: en-US
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <CAEvNRgE1dCVAxJWd_hyFa8N=m9JLfn97ip9tAmvHxspWJ50oGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0467.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::22) To PAWPR08MB10975.eurprd08.prod.outlook.com
 (2603:10a6:102:46e::7)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAWPR08MB10975:EE_|AM9PR08MB6209:EE_|DU2PEPF00028D0D:EE_|DU0PR08MB8089:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d700268-b808-4759-e3c1-08dec14e78c8
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|18002099003|22082099003|921020|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info-Original:
 dgSqH/7TcRrHp25inGfGMCLOQFTQCcgsY/At+cVJ3S+rc3o2L7R5iFxOd91Th8MDlWIaeJamEixrf2VOdhDDET/jYdLzuM2aOZsxPyTlCt5O+4PEbvGaC39PKmdJ67eWTecCw3dFhIsscyy5atxoOpFarQVaIeVRwLkjcpe+O+/iRgJXXb5wG1Gfx4zU9ccPMjLHcpwW2jFkZ6dAetTc313+7ie/5UVRawbJFw+fLI3+dtB/RcVKDcHi4TmnDKAdSuN8qkb6ymG92J194VuIH9xPsoFNj2ddT2ufxGoxeQzDowZJQq5F42FD+1L8k9RrPjk6gVCE0eR9qPleEPuvZQW6KbcSlNexfGhaT+Dl3rxWWJ0T9vZoXBaLMw295vj5TxczISZnNq+Tb4dv/pMcvXXfcSzAjZUNTrqp8HCLfow38WhRHQiul83L0R7MquSdvexmqcSVOBKTKC6UwXCPe0bUmOLgWRG+3FWox8Ye6PQ+Ut2OSLUNYvNY7bHosB6zLoOkU6RlxGy42ogkX/uH7WN3au34lO68Yg0xRSqdtI5W7TcgCRMCQRGtbyuXLsvy0srfEyPCl6Yi4oDmz0QPV1VaK1jKTrAsBrOeoDJGGrxA84dWzRb5i+wSoYVe3JvMAI4/x2x5exLbgeVtekW+A/8Esz1ovM+00UjjD9sc5ScxC6ryB0ppnGen21gzXDuKlsmFd2ehFBIQlBIG4LuYjYaw14Pxi8XzG4n8jqF4uTI=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR08MB10975.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(18002099003)(22082099003)(921020)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 Gd3Hh2Ae9/yd2amPs7sOt6Rk5pMuoIro+b9/FmtW/WBpkF9jrAEsPtCc5Xm/iWYoqB3ETElo2/1D8elcHl8oWzlUDpCeIauSFllBAN7w7j6YAmtQ1GPlfX/r15fMypQkDwV+0Ob2nraslnVmVVlEtHyWEgCFuX9bg2BwKj4aSWIwK3G+RJUWCyBuE6GsxStCo1DDhwGXuaD7mfwjF4gLrTzWFwZrrT4f88OdUYwcCxpB23mP8lXnWidmX8Y2Gmi4je4ljL3FWDLAithjQp628KR+0Whkh3alNkxBKQmH5fJt8yWBxuTNUwWTQAPPf/wu7yxULI78SAzr+4k/fZ2GvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6209
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D0D.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	eb36bd1c-5f50-4816-ff6a-08dec14e524d
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|36860700016|1800799024|14060799003|82310400026|7416014|376014|921020|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	xPEVART5tPqljK9TiG07pJo05hyN/la4jidp38npuFdQ3pohgTf6qlKfgjGOVecXoxl3YtmKgrBbjUbsdzC8JzzG8frWkdZv7eAQRy7aQHABp0JsZuiJf8Zaeaf+CMmntbMqx8frRBHtnngxW9Y1urlGAVOZkEGeqnX54r12hxQIV7Y5WC/2xjLEGgDjJ0Fw6iqa6wdjK3lXmUxaJeoBah8WW7MwI8ee/oExLp3azK15VeBAIGu6JpnSj1Lk1zP/+St5RvLLephOcSTy1CAxncSsLCRCr0q4faHVMOy+MkhTSXD1iC37wDJYj6gfJpGvJuOqljXYPHNl4FH9sz0wpJtis7r0kVI9moFx3vgYXTIEGU9UKkH/aOyHQdXnDbbZSx2Bau6ohqOvVdrhPaK2zQQxUZ5umyTgEJBDy4XiZ01FITZT9moTyuXokxi3D97cCLN1ghRr3BWpPbJky6a/7gXistOj9PPmfkrEFlTe2L0BZCgDF+YdzEwpqJAWAzq1QslzNf5YC7PQDPsw1Vf33VCbyitfv9dc4mYCsDNjCXr9AvITnngypAMkGj68BpkXhMx1ibJR+QcmYpoj35k7yzFhWba8eYuerhk7JO5hAE+Msy7+GyNz7OvFGMGnYiI9ySDEP3Zt6VVB5sge30KkciGHV0NCBX1S5hEP6cMxmw7RvsoAakwf1gCfIGEwA+rFQz71Hp6tWL8kvg9PMocNjh/DGjg+WMSruE5+GkI/rek8jrcwpGXyOeee1iEu0asBbf5YGnxzbN/D7aRiWvi/CA==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(36860700016)(1800799024)(14060799003)(82310400026)(7416014)(376014)(921020)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	L5K9EANu0Jy7D8re3NbJx1LUxUN0Xs33SN7LFRNVMStau4kn4fYYm2LgieMzSvFpK9F7CB9J+bC+ts/sWQ1UTMDTWsGijSbwjhU9EF0275a0JfQENDKrg/96rRuCBrh9Rn6r6lADEmJ99UcgPzqFM4EacvBfuZ0tkSmRiMVmHkRAyGWlfjsHUIblT2vOhiU3NDIGlkd/IjA+P3Ov7Bvq5B52V0k1Te/WIk88f6jclq5/JQ3wpTWns1eIeLltFpP8OZn8ZhL2ovYOX/Dn7WWUSK19d4ubySj/eCRjTTLhV2qYiQr78fqjw7kBjq1K/lq9vjPnfaW9QGC4dPwFYuFVvSU7JBnt4SjSMqp4DGgtbsf8U7Pttf1Rq7N5wE7CqkpR+ZPAy4XRPzl8xiM5zr3ZYAk7aHwBIYMSi4N+/et3mGbgBtco0EO/0CM6fJEmhjvB
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 08:59:51.0535
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d700268-b808-4759-e3c1-08dec14e78c8
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0D.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8089

On 02/06/2026 23:41, Ackerley Tng wrote:
> Suzuki K Poulose <suzuki.poulose@arm.com> writes:
> 
>>
>> [...snip...]
>>
>>>> @@ -914,7 +916,8 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct
>>>> kvm_memory_slot *slot,
>>>>            folio_mark_uptodate(folio);
>>>>        }
>>>> -    r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
>>>> +    if (kvm_gmem_is_private_mem(inode, index))
>>>
>>> Don't we need to make sure the entire folio is private ? Not just the
>>> page at the index ?
>>>       if (kvm_gmem_range_is_private(, index, folio_nr_pages(folio)) ?
> 
> I was thinking to fix this when I do huge pages, for now guest_memfd is
> always just PAGE_SIZE, so just looking up index is fine.
> 
> Is that okay?

Thats fine, but would be good to enforce that here, so that we don't 
miss out when we add support for multi page folios.

> 
>>
>> Or rather, we should go through the individual pages and apply the
>> prepare for ones that are private ?
>>
>> Suzuki
>>
> 
> IIRC the plan was to make kvm_gmem_prepare_folio() idempotent, as in, if
> a page is already private, just skip. Currently sev_gmem_prepare() does
> a pr_debug(), which I guess is technically still idempotent.
> 
> I'm thinking that the information tha needs tracking to make
> .gmem_prepare() idempotent should be tracked by arch code.
> 
> Does this work for ARM CCA?

We don't hook into the prepare yet, but have plans to do that. We should
be able to handle the pages that are already private. (For CCA context,
RMI_GRANULE_DELEGATE_RANGE can skip over already REALM pages). So this
should be fine.

My point is, in a given folio, there may be pages that are shared.
Like you said, this could be dealt with when we support hugepages.

Suzuki


> 
>>>
>>> [...snip...]
>>>

