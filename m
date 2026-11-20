Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.81
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795205254;
	b=LVZ+Jfc6+ZXtRuOSamA5+TdjTLfbrD6bbWn4DUkqKzlNBW6VBozXlAsLRFporHawzxnd
	 nKCZwpBC2Q+K6ashwEYT21N1I98Bgk7HEffcoypHWhTdbjt1pv6YFG6/3nrs6ogXxDZCV
	 e0kXdKbMmq4sH2wSNcxn9Cfr4xdALlcg9cKoLZgUeJDgK0IuuUfLPDZDVA6HA7TSa2p+k
	 3l8BY4XXN4HOVb8tF4UKVM8AD8XyjW0nlFL0GDA2fAbFXQtUuuPjrKKoirtHfAFSMYyiA
	 UvQWI7E8X5tQYlxyymTuFFxj1heZQE2QSwfx5q/0EoG5AE573+CPMvEYBYaw5ui23Gg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795205254;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-slblob-mailprops:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:
	 X-MS-Exchange-CrossTenant-rms-persistedconsumerorg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=6I+ngaNXdJjUiX4Cfvi4lejVKhK9n9NoYEna6WDNw1Q=;
	b=gjTBPgmi+jGO5AYVOtkBo1QOoDhxFfe/lDTj0wDiFvIG0TdfgAAeLOF7KPJ6InNNMmXp
	 MLoKnTw5LWTmQ/nXuhU1pMnCW6oj0UGL3uXRUzHLN9wJf+GtuIfbe/RTvIRzVFCl+YqJC
	 Zwy2SnqEvMsXREwtK7BFtSkPhyyPJWSqV6wLgG9RthU0vTi2TnSAAj+u7sibXSeD9M3yD
	 3x9dOFp07Ze/sGNYJ8+TY+LbbwvCGBA/jt/q9SKWIdNbTJxBkCfwbVQPxOCVb/gBN4jkS
	 K3VgIUyDJ2iZttTjnZt5hkOkvHNjT9CeWLNG2Moj4/jy8vciD2RbqOcMAg15TRjRhwg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=jLg5UwQ3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.81
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazolkn19012081.outbound.protection.outlook.com [52.103.20.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985D9606A6E8;
	Fri, 20 Nov 2026 20:07:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 985D9606A6E8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=jLg5UwQ3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EQZ5q27SN66Rl4ye4efeDMmpTjEsChC2rQLaAJJ970994CbnBRsay1jLZMAfMz/RGrml6YCMwWRqMJDtW+x1T4ktlwuFQvM7bx0VEpY84ZSlBNmcBXLVZWPruMQvGiQg5gjw6rcjJ20H8JyM0dbvJyT7LZRGya7AvPbUfbpEbkFU5zcCHBLy/1qVwaqi2nmTP0zR9IFB8GU9sG7tQhSb4qIj+0KDgy5VUykmpKUjsX3bud7vjetj533Gx0FrKPY9a1BPWhUJ0/wL5sIE+8lJQsPonnwDNmBl/UOH0GB8d0gFsiW7A3lgtOatYtVdDn0Q+HLnV2H02jMVvhlse7au4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6I+ngaNXdJjUiX4Cfvi4lejVKhK9n9NoYEna6WDNw1Q=;
 b=nGl2y8Pj+flixSF9rezZOFG3KcPTNEp0TD+9/2BW5YWrU8sdtxLnWjKp/7PQgcwwPRc15UDYam+4dGs0yDkDpQfmAGB4i/vjWvlJ6BqbEA09YRYdwxLIGN5wvjX9eQuRIxQNYv0qGywoRswUNlDyCSeV5+4bzOxnKiN2Wch6F1NhFSbiO9lFvTHbrPikhUTxmgt+ShJsWpxJKUFUVRJxPkFD6+oaAmo1YDfyb9kHekFxw1GqRQ9gKivnczZxvAEsCIEUpcl6Ib/FzYYkGs6V+jul8mJQ3MQu2pi9LiLAWlnKFCAzYxgCuklXQ6WsHl0oo6fUQhZ3LBQkm5KtmS1QeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6I+ngaNXdJjUiX4Cfvi4lejVKhK9n9NoYEna6WDNw1Q=;
 b=jLg5UwQ3PH3mb7TJZUXuPy3Y6JC70LDpQYBu2GFTwbGI/6BzSjXJbRWVxBYeZmwXg3e3e5whaoeGT2BA39p+cH/YfcARqsRyFzeC403LcekMqTBL/hLW3c6A1G7iGfn7ek5m7/D6zAQjhhvoSa1G8GwiEPuE5SwToI07UMqY6N/BJY8bkuvoabtIrnKOacXbs2y9UGf4gbNYTXS8CYKu0FTIaAAqetWmqgS7vhuVwLjLko+1he3CiKGbkDkiv0pp9s9rgWqS4O6mWSappQOz+M0pLeVLLCiTLe+mBdSBQoSwpezrp/NN9L7cYV8s7aUWs0tVm2W9PvrkPPOxmnJ5Pg==
Received: from MN2PR02MB6863.namprd02.prod.outlook.com (2603:10b6:208:1d7::20)
 by CO1PR02MB8635.namprd02.prod.outlook.com (2603:10b6:303:15e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Fri, 20 Nov
 2026 20:07:28 +0000
Received: from MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53]) by MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53%4]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 20:07:28 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich
	<dakr@kernel.org>, Johan Hovold <johan@kernel.org>
CC: Jonathan Corbet <corbet@lwn.net>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Bradley Morgan
	<bradley.morgan@linux.dev>, Armin Wolf <W_Armin@gmx.de>, Masami Hiramatsu
	<mhiramat@kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "driver-core@lists.linux.dev"
	<driver-core@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 01/10] driver core: Disable driver overriding by
 default
Thread-Topic: [PATCH v2 01/10] driver core: Disable driver overriding by
 default
Thread-Index: AQMfJRX+ztp9Zvox4aPtllK0egdUugGtXib4tKZ5d2A=
Date: Fri, 20 Nov 2026 20:07:28 +0000
Message-ID:
 <MN2PR02MB6863ECE0C9CC59979692D2ECD4782@MN2PR02MB6863.namprd02.prod.outlook.com>
References: <cover.1795171088.git.u.kleine-koenig@baylibre.com>
 <f7b5c6319203d288a166e6f811c6ea07e12d5f4f.1795171088.git.u.kleine-koenig@baylibre.com>
In-Reply-To:
 <f7b5c6319203d288a166e6f811c6ea07e12d5f4f.1795171088.git.u.kleine-koenig@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR02MB6863:EE_|CO1PR02MB8635:EE_
x-ms-office365-filtering-correlation-id: 951f42da-bc45-498d-8380-08df4741e723
x-ms-exchange-slblob-mailprops:
 WaIXnCbdHrO+2YmbT5jW+WUSUt4IT5vRLLrm+SOU1D8ozK8ImpPIf/tC5qsQIIvfBMhrC7o5xoCJhX7kvEnzxuG9G0c9vkpCePwCJN6/725GD7bZPXb+qnbsMpUwZnh8mdje1FgU1f93IcSAIhpq4Rdb3bj0DiSUKk/9iQx+4VxC7kV5xt+sg6DC1g3Gm+0406Izcg0bHwmi94JgVRVjxwk7va4VE3UY+949EyrYJ3vwmbKePxKR2VDY/oTeokNNcE6/29kW3KYwzrtjk1Qom1ZHGBVb4v34MJ0YNJgYGEY9+cnr4Mx3YoRrHS4XoI7RpQfUlWzWgrr/popZrRmRHeM4GRFzLAX/vnuxN0RT80zq8pf1TsRc1O33hDphkGVK+tRNa0lR04bqcBnAcd0KjL33+2X1OMz2oK29vjRv34E1iqY70S/xVK5zEOYGy84Gqz+MURhKmOitaXVNcOZZhtzg/6bbMY/8hAx/d9yN1RUSzjtX5UCYy+ZMcfyDRceiclePd0mSNq0Q5uoiJ9NBTRShz7l4rqFQ+RJlCxIZKm7wR21VWp5TsHuRyf7RN4xPwZjbb+QSbiKD5N3Rw9LRi3U2yNcx+Qn4Sms54T3tAAbCakf6FiMl0CYvF8qAvILY+wudzdZTzXg8F2RfJJ7RZd2jnh4/0rcJpKNno7ak55V7LmxGE2NThEzJaqL/C6BU4EslPNFVWOx9aPiJ/ibnUlz3WqTToKsINX35tSev72sdnqB3tSEoTW9Kt21Y+TgCA4w6XcrDQFc=
x-microsoft-antispam:
 BCL:0;ARA:14566002|55001999006|19110799012|8060799015|8062599012|24021099003|12121999013|25010399006|17081999003|51005399006|13091999003|41001999006|10092599007|31061999003|15080799012|37011999003|40105399003|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?i8wlu4/mMCfJ3kMc7uxA8OxCiXxpWk4lCX+8uSXsZrm0zPsNnr70gnQQhf?=
 =?iso-8859-1?Q?yqHurWuCJvdsnEobxpLdT9hlLeyNbRy6oKO5o0ebPEFW5rgkbdu3A0MQ0Q?=
 =?iso-8859-1?Q?lVAWYS3rvlawJ0iBD87FEqkcFZmievf8s/owyP+ggBWFKon571++Noi7g7?=
 =?iso-8859-1?Q?DGfzQJvaLPgO6ThaxbxMEZawqtwELgp7cpOHcSzeLv8fGejB/yGfH8RfUf?=
 =?iso-8859-1?Q?xR1w69fNW0Ay6RSPz7ayXcV3YMJlSlCR0JxAKvb55vzpcDUzqaFkMTL6Tg?=
 =?iso-8859-1?Q?0ca5PuyySTa/PHuvxv8mlTm7ldDf1aAcNKhuVO+eI+Zn5VstnmecccmMHo?=
 =?iso-8859-1?Q?NJtIGT8orkq1ywfg2L2Sa15XbcucstQxFPBqF0xGvbMACA+rVWt1GpgkX/?=
 =?iso-8859-1?Q?AZ3dUXg1bLc/vdT2VsMYlnjk1lN14CwW64RLsiTC0lvmUC33H4FQ27A1XR?=
 =?iso-8859-1?Q?lCExFwojzoRA22cIxQScE4srB3DSyfEJfYKQhtWX+nnlg23EAHIPmb1sgM?=
 =?iso-8859-1?Q?Bb8XeUMx43bf1An3I0a9ex5C0jEHNCsjb8WUNdXrpBhqnA+Xj/BZyhf8Vd?=
 =?iso-8859-1?Q?D4c3AxocNTm5hpjCVBs63GziHVvbbIkrd9S9kjCoA4dYud5QJlFIHzzIGK?=
 =?iso-8859-1?Q?yoUmgSysiG1IFwAaRc8Al8wL35iLclDSksJIc04F3uuPMx2cLMQlpJa5N8?=
 =?iso-8859-1?Q?V1eHrMHo8wZ31ASj0Kr3F03a1D+vF+q6rXVbAyiBSSRoJmR7G7qYOefPIX?=
 =?iso-8859-1?Q?6LUghMe0Stjy4GgWUhZkfs7RYseR2jWJHdQbtYQSQbpFT9AzRLq3mNWt/M?=
 =?iso-8859-1?Q?a1VihY+PPCWEiecTcngv09EWrzEsfTYnyuorniLV1vddChFphb6LC6MvTZ?=
 =?iso-8859-1?Q?ydP26lrqVn4tbYWdUgrNQgJeKpM0CsdJcrYOeSpbFjo4prbx26lEohvAvz?=
 =?iso-8859-1?Q?DZPk653wVdKZRNztD4nIxGNwJO5v3OQ/S7tJFFRpEgy5OsPPApSyuJc6wx?=
 =?iso-8859-1?Q?kWtZFAPEqqSlx08EcVRzfOZi1KAF0VT6o94uvck1iw4UlOfHxKI2+thvMq?=
 =?iso-8859-1?Q?8rH1VcqyI0jv4yp38X34V+oTUiZASYWR89K6ZZpF+oVtAyOG9qT2DEHkk2?=
 =?iso-8859-1?Q?1nqtyLrz+jP3YF08YGNbBSsdn4b2pLfQdNzBPYZJtgmylGL/o8jAgCCgn4?=
 =?iso-8859-1?Q?zd0S7LYdNUEuixZjtQtR9+5L/MEu4YAn3R4=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?YugpQLLN4r8BCjcgGavYHk3uO4+qS2zHnR3sQzBQBV608RCGPSl+1ICs0u?=
 =?iso-8859-1?Q?z3ZsVGQWgstFcZvrxa81poFiI48WZNWHzf41dUSqAD6t5DlGGaaNgeAIU3?=
 =?iso-8859-1?Q?OUcWYqlZzUlb497rKsu3GDBEQUb2CrhtGMohWX6u5+duqIwnYrh6+i74ir?=
 =?iso-8859-1?Q?n97Helxtjzlt8YhkyBc4gCOUQDfKt9nwJZUsU4RrqE/HFfhP6kA/CE6saM?=
 =?iso-8859-1?Q?x/aQjzpDkjfWPzXQBUZduEY1tiOReYoX3oe4jL57mVwwc94254G6Xw4R4F?=
 =?iso-8859-1?Q?IJBz7WtJxnW2AK5h6y2Jf06U9/PdmX0NqiWnSngH1F+SpIeRsM7OGy/iYc?=
 =?iso-8859-1?Q?dFO+9LPOHv37Kmv3xPv4mPACX1V3znz1jEwnmPsQptE7mbm+ot+fGODMG1?=
 =?iso-8859-1?Q?w4lg/U+ls+zYuPGcLbsb4LlGJe7ABuXNCP38Ow4aPGQ5MDX1H4zVbl3a9f?=
 =?iso-8859-1?Q?REXtUjItgUy8jvLtGUcCr5xJYR+bE6Nir4y5sjQKFanyHA0hmnU9IP5VBv?=
 =?iso-8859-1?Q?ub1XVOD59DaY+SAlc8eOe2KfPJqFkPAdvWb0dssW+qRtyKQLC9QkqlSPOu?=
 =?iso-8859-1?Q?G1VuRDVw7h3vHumapep2iFPP2BwhEiGIbG/ll2TUcTwXLz+V7PrwNAkbjD?=
 =?iso-8859-1?Q?0nJxrrmCMjtQHsOZidnm1bpuea7h9Emx1CPiPfC9qZOVgpPLU+UJJLQEVb?=
 =?iso-8859-1?Q?1fCxyKjGoTPhLML+jfRl9hymF5EeA4YDlcXSDThgsOYQpKbcwYss7ISpp2?=
 =?iso-8859-1?Q?6vg66XMtsxILtMY657yqG35CYcPJ2bnHd/M8oVF2ISTL83MH/Ar4mR3oKI?=
 =?iso-8859-1?Q?V7jH2SIZc3OiLIQLk1e5h1Tc9Mp0jg83d03m0xTfwZ8kKLBYsu1mitPYNc?=
 =?iso-8859-1?Q?nxwMBRrlUs1d6hrp+iRwQTEFYbZYMP+cFRQATeWGCxiA+D+2CpIHiPq7FY?=
 =?iso-8859-1?Q?9ynzZFe/9JcLHBFv2/7IlQ/L2Ox6nFi7CU7JKFeQHSd+fPpgPJypGui47R?=
 =?iso-8859-1?Q?YR42qIiKVGlRi/H7SZXN6vIbwFtyEC+3civ7JqaAYaQbvJ1graAEMzd5fG?=
 =?iso-8859-1?Q?r8faz0g3kRB2aUBnV3hxDa7ujmaRSXuJtR8AKvQLX5Vw9MXgV0iQHPoRKB?=
 =?iso-8859-1?Q?67Un6P9+SYDB3dzyhZEtRdsDTALXlYja3SRiXTt8TZjblXI9Zxlh8tP9PD?=
 =?iso-8859-1?Q?ar1COPb8WdsPopiGc3rwy9iLIWI1Iq5hyxZsgaaOTYN6MI367/NpzcC1WA?=
 =?iso-8859-1?Q?t349o9jdBiqX0Y0K02ElTti10dyUMkxh8E7KkXNwj0OTO4UTc0HTl5jDp1?=
 =?iso-8859-1?Q?vU8LDG8bX9SUWn1ThEjbBjUSrojfQrL0Aj24EGQESX+ZjasISFpZfzw66U?=
 =?iso-8859-1?Q?t3Ir5jh8ns6IIFj+P2DhVFWlpV0YS/52lAqRJFKvCKeTkNDVWm2+M=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR02MB6863.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 951f42da-bc45-498d-8380-08df4741e723
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2026 20:07:28.6143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8635

From: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com> Sent: Friday, Novem=
ber 20, 2026 3:11 AM
>=20
> Driver overriding is useful only in a very limited set of situations
> and then only with very few drivers that are designed to support that.
>=20
> Disallow matching via driver_override unless the driver explicitly
> allows it or the safe guard is disabled using the
> "allow_driver_override=3D1" kernel parameter.

The "=3D1" syntax is no longer accurate.

>=20
> There are many drivers that don't expect to be force-bound and often
> doing it anyhow results in a NULL pointer exception. To make debugging
> such cases easier, add a new taint if such a forced match happens.
>=20
> Implementation detail: device_match_driver_override() isn't a static
> inline any more. It grew a certain complexity (e.g. a pr_info()) and so
> was made a regular exported function.
>=20
> Reviewed-by: Bradley Morgan <bradley.morgan@linux.dev>
> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Modulo the nit in the commit message,

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>

> ---
>  .../admin-guide/kernel-parameters.txt         |  6 +++
>  Documentation/admin-guide/tainted-kernels.rst | 54 ++++++++++---------
>  drivers/base/bus.c                            | 51 ++++++++++++++++++
>  include/linux/device.h                        | 19 +------
>  include/linux/device/driver.h                 |  2 +
>  include/linux/panic.h                         |  3 +-
>  include/trace/events/module.h                 |  3 +-
>  kernel/panic.c                                |  3 +-
>  tools/debugging/kernel-chktaint               |  9 ++++
>  9 files changed, 105 insertions(+), 45 deletions(-)
>=20
> diff --git a/Documentation/admin-guide/kernel-parameters.txt
> b/Documentation/admin-guide/kernel-parameters.txt
> index 8228c9acc530..ed505e362b1d 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -424,6 +424,12 @@ Kernel parameters
>  			do not want to use tracing_snapshot_alloc() as it needs
>  			to be done where GFP_KERNEL allocations are allowed.
>=20
> +	allow_driver_override
> +			Allow matching drivers without
> +			.support_driver_override =3D true to devices using
> +			driver_override. This is a dangerous operation in
> +			general allowing root to oops the kernel.
> +
>  	allow_mismatched_32bit_el0 [ARM64,EARLY]
>  			Allow execve() of 32-bit applications and setting of the
>  			PER_LINUX32 personality on systems where only a strict
> diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentatio=
n/admin-guide/tainted-kernels.rst
> index fcb8b9734548..f4ddb63dc704 100644
> --- a/Documentation/admin-guide/tainted-kernels.rst
> +++ b/Documentation/admin-guide/tainted-kernels.rst
> @@ -74,35 +74,36 @@ a particular type of taint. It's best to leave that t=
o the aforementioned
>  script, but if you need something quick you can use this shell command t=
o check
>  which bits are set::
>=20
> -	$ for i in $(seq 0 19); do echo $i $(($(cat /proc/sys/kernel/tainted)>>=
$i&1));done
> +	$ for i in $(seq 0 20); do echo $i $(($(cat /proc/sys/kernel/tainted)>>=
$i&1));done
>=20
>  Table for decoding tainted state
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> -=3D=3D=3D  =3D=3D=3D  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -Bit  Log  Number  Reason that got the kernel tainted
> -=3D=3D=3D  =3D=3D=3D  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -  0  G/P       1  proprietary module was loaded
> -  1  _/F       2  module was force loaded
> -  2  _/S       4  kernel running on an out of specification system
> -  3  _/R       8  module was force unloaded
> -  4  _/M      16  processor reported a Machine Check Exception (MCE)
> -  5  _/B      32  bad page referenced or some unexpected page flags
> -  6  _/U      64  taint requested by userspace application
> -  7  _/D     128  kernel died recently, i.e. there was an OOPS or BUG
> -  8  _/A     256  ACPI table overridden by user
> -  9  _/W     512  kernel issued warning
> - 10  _/C    1024  staging driver was loaded
> - 11  _/I    2048  workaround for bug in platform firmware applied
> - 12  _/O    4096  externally-built ("out-of-tree") module was loaded
> - 13  _/E    8192  unsigned module was loaded
> - 14  _/L   16384  soft lockup occurred
> - 15  _/K   32768  kernel has been live patched
> - 16  _/X   65536  auxiliary taint, defined for and used by distros
> - 17  _/T  131072  kernel was built with the struct randomization plugin
> - 18  _/N  262144  an in-kernel test has been run
> - 19  _/J  524288  userspace used a mutating debug operation in fwctl
> -=3D=3D=3D  =3D=3D=3D  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +=3D=3D=3D  =3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Bit  Log   Number  Reason that got the kernel tainted
> +=3D=3D=3D  =3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +  0  G/P        1  proprietary module was loaded
> +  1  _/F        2  module was force loaded
> +  2  _/S        4  kernel running on an out of specification system
> +  3  _/R        8  module was force unloaded
> +  4  _/M       16  processor reported a Machine Check Exception (MCE)
> +  5  _/B       32  bad page referenced or some unexpected page flags
> +  6  _/U       64  taint requested by userspace application
> +  7  _/D      128  kernel died recently, i.e. there was an OOPS or BUG
> +  8  _/A      256  ACPI table overridden by user
> +  9  _/W      512  kernel issued warning
> + 10  _/C     1024  staging driver was loaded
> + 11  _/I     2048  workaround for bug in platform firmware applied
> + 12  _/O     4096  externally-built ("out-of-tree") module was loaded
> + 13  _/E     8192  unsigned module was loaded
> + 14  _/L    16384  soft lockup occurred
> + 15  _/K    32768  kernel has been live patched
> + 16  _/X    65536  auxiliary taint, defined for and used by distros
> + 17  _/T   131072  kernel was built with the struct randomization plugin
> + 18  _/N   262144  an in-kernel test has been run
> + 19  _/J   524288  userspace used a mutating debug operation in fwctl
> + 20  _/Z  1048576  A device was matched using driver_override to a drive=
r not supporting that
> +=3D=3D=3D  =3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>  Note: The character ``_`` is representing a blank in this table to make =
reading
>  easier.
> @@ -189,3 +190,6 @@ More detailed explanation for tainting
>   19) ``J`` if userspace opened /dev/fwctl/* and performed a FWTCL_RPC_DE=
BUG_WRITE
>       to use the devices debugging features. Device debugging features co=
uld
>       cause the device to malfunction in undefined ways.
> +
> + 20) ``Z`` if a device was matched using the `driver_override` sysfs pro=
perty
> +     to a driver that didn't explicitly allow that.
> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> index 396097fdb316..1b4dd98a1286 100644
> --- a/drivers/base/bus.c
> +++ b/drivers/base/bus.c
> @@ -603,6 +603,57 @@ int bus_add_device(struct device *dev)
>  	return error;
>  }
>=20
> +static bool __read_mostly allow_driver_override;
> +
> +static int __init allow_driver_override_setup(char *str)
> +{
> +	if (!str || *str !=3D '\0')
> +		return 0;
> +
> +	allow_driver_override =3D true;
> +	return 1;
> +}
> +__setup("allow_driver_override", allow_driver_override_setup);
> +
> +/**
> + * device_match_driver_override() - Match a driver against the device's =
driver_override.
> + * @dev: device to check
> + * @drv: driver to match against
> + *
> + * Returns > 0 if a driver override is set and matches the given driver,=
 0 if a
> + * driver override is set but does not match or is ignored, or < 0 if a =
driver
> + * override is not set at all.
> + */
> +int device_match_driver_override(struct device *dev,
> +				 const struct device_driver *drv)
> +{
> +	guard(spinlock)(&dev->driver_override.lock);
> +	if (dev->driver_override.name) {
> +		int ret =3D !strcmp(dev->driver_override.name, drv->name);
> +
> +		if (ret && !drv->support_driver_override) {
> +			if (allow_driver_override) {
> +				add_taint_module(drv->owner,
> +						 TAINT_DRIVER_OVERRIDE, LOCKDEP_STILL_OK);
> +			} else {
> +				/*
> +				 * If you hit this warning and you need to
> +				 * quickly workaround this check, boot with
> +				 * allow_driver_override=3D1 on the kernel
> +				 * commandline. The right fix is to set the
> +				 * driver's .support_driver_override property.
> +				 */
> +				dev_warn(dev, "Denied matching to %s via driver override.\n", drv->n=
ame);
> +				return 0;
> +			}
> +		}
> +
> +		return ret;
> +	}
> +	return -1;
> +}
> +EXPORT_SYMBOL_GPL(device_match_driver_override);
> +
>  static void __bus_probe_device(struct device *dev)
>  {
>  	struct subsys_private *sp =3D bus_to_subsys(dev->bus);
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 6b082c638d45..05413c1a9454 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -907,23 +907,8 @@ static inline bool device_has_driver_override(struct=
 device *dev)
>  	return !!dev->driver_override.name;
>  }
>=20
> -/**
> - * device_match_driver_override() - Match a driver against the device's =
driver_override.
> - * @dev: device to check
> - * @drv: driver to match against
> - *
> - * Returns > 0 if a driver override is set and matches the given driver,=
 0 if a
> - * driver override is set but does not match, or < 0 if a driver overrid=
e is not
> - * set at all.
> - */
> -static inline int device_match_driver_override(struct device *dev,
> -					       const struct device_driver *drv)
> -{
> -	guard(spinlock)(&dev->driver_override.lock);
> -	if (dev->driver_override.name)
> -		return !strcmp(dev->driver_override.name, drv->name);
> -	return -1;
> -}
> +int device_match_driver_override(struct device *dev,
> +				 const struct device_driver *drv);
>=20
>  /**
>   * device_iommu_mapped - Returns true when the device DMA is translated
> diff --git a/include/linux/device/driver.h b/include/linux/device/driver.=
h
> index 29fbc01ef06f..0153cfcbe1b9 100644
> --- a/include/linux/device/driver.h
> +++ b/include/linux/device/driver.h
> @@ -56,6 +56,7 @@ enum probe_type {
>   * @bus:	The bus which the device of this driver belongs to.
>   * @owner:	The module owner.
>   * @mod_name:	Used for built-in modules.
> + * @support_driver_override: driver_override only works if this is true.
>   * @suppress_bind_attrs: Disables bind/unbind via sysfs.
>   * @probe_type:	Type of the probe (synchronous or asynchronous) to use.
>   * @of_match_table: The open firmware table.
> @@ -104,6 +105,7 @@ struct device_driver {
>  	struct module		*owner;
>  	const char		*mod_name;	/* used for built-in modules */
>=20
> +	bool support_driver_override;
>  	bool suppress_bind_attrs;	/* disables bind/unbind via sysfs */
>  	enum probe_type probe_type;
>=20
> diff --git a/include/linux/panic.h b/include/linux/panic.h
> index 17e61b61c45f..009232511cc7 100644
> --- a/include/linux/panic.h
> +++ b/include/linux/panic.h
> @@ -89,7 +89,8 @@ static inline void set_arch_panic_timeout(int timeout, =
int
> arch_default_timeout)
>  #define TAINT_RANDSTRUCT		17
>  #define TAINT_TEST			18
>  #define TAINT_FWCTL			19
> -#define TAINT_FLAGS_COUNT		20
> +#define TAINT_DRIVER_OVERRIDE		20
> +#define TAINT_FLAGS_COUNT		21
>  #define TAINT_FLAGS_MAX			((1UL << TAINT_FLAGS_COUNT) - 1)
>=20
>  struct taint_flag {
> diff --git a/include/trace/events/module.h b/include/trace/events/module.=
h
> index e5a006be9dc6..d54ce3c7572b 100644
> --- a/include/trace/events/module.h
> +++ b/include/trace/events/module.h
> @@ -26,7 +26,8 @@ struct module;
>  	{ (1UL << TAINT_OOT_MODULE),		"O" },		\
>  	{ (1UL << TAINT_FORCED_MODULE),		"F" },		\
>  	{ (1UL << TAINT_CRAP),			"C" },		\
> -	{ (1UL << TAINT_UNSIGNED_MODULE),	"E" })
> +	{ (1UL << TAINT_UNSIGNED_MODULE),	"E" },		\
> +	{ (1UL << TAINT_DRIVER_OVERRIDE),	"Z" })
>=20
>  TRACE_EVENT(module_load,
>=20
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 91e48d33b7db..81ea9ef9afb0 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -825,6 +825,7 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT=
] =3D {
>  	TAINT_FLAG(RANDSTRUCT,			'T', ' '),
>  	TAINT_FLAG(TEST,			'N', ' '),
>  	TAINT_FLAG(FWCTL,			'J', ' '),
> +	TAINT_FLAG(DRIVER_OVERRIDE,		'Z', ' '),
>  };
>=20
>  #undef TAINT_FLAG
> @@ -861,7 +862,7 @@ static void print_tainted_seq(struct seq_buf *s, bool=
 verbose)
>   * exact size is allocated dynamically; the initial buffer remains
>   * as a fallback if allocation fails.
>   *
> - * The verbose taint string currently requires up to 327 characters.
> + * The verbose taint string currently requires up to 348 characters.
>   */
>  #define INIT_TAINT_BUF_MAX 350
>=20
> diff --git a/tools/debugging/kernel-chktaint b/tools/debugging/kernel-chk=
taint
> index e1571c04afb5..56215e0f5112 100755
> --- a/tools/debugging/kernel-chktaint
> +++ b/tools/debugging/kernel-chktaint
> @@ -211,6 +211,15 @@ else
>  	addout "J"
>  	echo " * fwctl's mutating debug interface was used (#19)"
>  fi
> +
> +T=3D`expr $T / 2`
> +if [ `expr $T % 2` -eq 0 ]; then
> +	addout " "
> +else
> +	addout "Z"
> +	echo " * A device was matched using driver_override to a driver not sup=
porting that (#20)"
> +fi
> +
>  echo "Raw taint value as int/string: $taint/'$out'"
>=20
>  # report on any tainted loadable modules
> --
> 2.56.0.rc1
>=20

