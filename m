Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023094.outbound.protection.outlook.com [40.107.44.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E3E30FC03;
	Thu, 21 May 2026 01:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779328362; cv=fail; b=pAK313fCfno4fmXod606nVcZTz5uf15Fl/ipJPEgZvjZsW8ZwVx4BPC38g2Ns/oz6QyzcCMS+eHULAsVvVV0qaeA015cOHabAX20Mipke6q1KxBI1hORTUhMJb7uo2qXemgdzN0fkuYdxNGGq0mdrO5dxKmDBe+8D9+GHLBE440=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779328362; c=relaxed/simple;
	bh=LCxdGwO0qad6QReyogYQA9dGJhcQC9Z8XY8kIib+A5g=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KKmX6M+4W5XtJrVrh+8x/gErB21PYkJ6rJmACqCv4tvTPVAHvvXk7Fo68PRlngO3l0oLwz1t1DCYaY4BfNWCNiWH3IiEQIIOGZdCnD+Ro9DdrENF1pPH02UhYCm9kWEfLQfHzJW3bOpQJqaMjhmg9awYfR7hYFP6HBITl0nww5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com; spf=pass smtp.mailfrom=transsion.com; dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b=g5BM9a25; arc=fail smtp.client-ip=40.107.44.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=transsion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b="g5BM9a25"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XO/UoIBnh/U5Zk9jZnScULNzfBUn1yUShw3mUogjnniRW4EqJTz+roWWAbcq7MJV8QkHg9G6GMX3985C8U5A05ft5H4QrkwC90bnFcLM3sXRf28D/zSB7rBTDKtG+AOYlaQVzLsrB7R8WZVxxODvhWiw0hmVWNtfOId5QufeKzSGbiIKpx79KB9hB5jKvE3wGu3CM8KA4RLd8CWKiMss3CGx1SDdOTxHK+yWVCMp2X7lMkPzoPF9xS6dXG3dGGiXgWBedEsgqjKFT3N3bz2HSyIDEFSIvPiu2Af/NKwZsHFMs8dFF8EGs8UzDXP6k+77/AS8pmykyI1Q9zJvBweESw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+yOnqhX4o4yssOseXwfiZNCVYFwftpmrdMrUn6i6puA=;
 b=rdUik4R2lVlHv6F2nmgPIPDamaqotILDe/Gzlu7br4HE0VGkKOyFN9fpcz8t2eAzxwYV8dUaYcTQvldXnabYWTrri0jR26lOJ4vPVqUsiHJnhEc0WDiHJSUeg52RYK1u3mfo8LlgRf3FNFziIBV6fhzer9vW1w9WbKl6OPkVSig6yd3rhJLqW0XGvz5Ju7KP2w5oEXY95Nq/RTI9zcJ78l2/BkuMWRYfmQmLPKM903xQna6XfnU3k4w8shDHhyF7WuGDe+BMOpGww7wL0UIkYtlMmNoCgrYXIquxMvCkHDYkMAfloocXlnxMx9umJds6+vAlgzq8VVzOY9RJYCzcfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yOnqhX4o4yssOseXwfiZNCVYFwftpmrdMrUn6i6puA=;
 b=g5BM9a25RP6W/rLOZ0bKp6UyU5IWTQcAsxjavHFB1xRJv57U7r1O+Va/Mw+M//A+mccZapH9DjmwoBTwK5W1CF136wDyDrXcUBuyCjCH1Ddu5Hde/e1amvbQn8CF2WCYAGZ5CpaYkEIjNqpksHwuk95cdq9xDrVN85+Cx0nBh7M=
Received: from SE3PR04MB8921.apcprd04.prod.outlook.com (2603:1096:101:2e8::6)
 by TY1PPFED9C01C26.apcprd04.prod.outlook.com (2603:1096:408::aab) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Thu, 21 May
 2026 01:52:34 +0000
Received: from SE3PR04MB8921.apcprd04.prod.outlook.com
 ([fe80::ebed:1dee:3932:9ba2]) by SE3PR04MB8921.apcprd04.prod.outlook.com
 ([fe80::ebed:1dee:3932:9ba2%3]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 01:52:34 +0000
From: ao.sun <ao.sun@transsion.com>
To: "rostedt@goodmis.org" <rostedt@goodmis.org>, "mhiramat@kernel.org"
	<mhiramat@kernel.org>, "mathieu.desnoyers@efficios.com"
	<mathieu.desnoyers@efficios.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>
CC: jiazi.li <jiazi.li@transsion.com>, hongyan.xia
	<hongyan.xia@transsion.com>, ao.sun <ao.sun@transsion.com>
Subject: [PATCH] tracing: Fix README path for synthetic_events
Thread-Topic: [PATCH] tracing: Fix README path for synthetic_events
Thread-Index: AQHc6MR+t6rVt3pTeki7HOM9ygXN9g==
Date: Thu, 21 May 2026 01:52:34 +0000
Message-ID: <20260521015211.111-1-ao.sun@transsion.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transsion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE3PR04MB8921:EE_|TY1PPFED9C01C26:EE_
x-ms-office365-filtering-correlation-id: 4c4e5d50-7f3a-4d6d-d905-08deb6dba0e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|42112799006|1800799024|38070700021|18002099003|11063799006|56012099003;
x-microsoft-antispam-message-info:
 tJ1/jYXOc+4p1aCvokw91nU8nPLeZOaB3i742jlywB02zc3qsXomD6kXfrgWUuNcLZR1v99CoaAyS0Lk2jNmmz9FE7Z3mY2JMjBnq1XRzu1HzncoFK1HvCqjTpAyxdk00OepJ018Hr9Jw09vCI0uVp2njeevpYfpPAFz8A48ELACL14GpEgkoa9/Dsxv0zwMGM98XF3QGhNqEBSWnZ0YKnr98Uwvy4F+msmaMmUgCg20aB1becUtHNIr9flAlz+KSCyHV9TmwLZyYDgSoh37otJs7WxQtsBX9iTh6j1Jq2l2fr7vkIWdAYTSimXRylqvAzmzjt7EmbLrpnXtkgOnaPsYnvzv9EWAbjWkwLJyGwFFyZlWGoGomVGTWvE/Pzp7/5cHyil3YgZIJGsQEruSMkogOpXbWacjqIIaPi/+fiOHPlkxsKxlQkjp15oS7rfe8wJez1WOixnmzrlkCDXZ2k/gMp1y8HLWDb/9lhJaIv1G89QKcUha54ttNOGtvnTmiz9IlFvMHk3FbCe0bMQxRN+XMVOUgOuaES3IuDDGYv06eZrilGIn3g9qFXC5qoS/9+G6gsxlzxwk9OL1WKIZ7QfZYEY1bTweaeBk0q9Qgx0zK1c1I4gYMK1QSOtiyrqnWyb5AWrn3F2xSYWBtncmNiRcZ53ChjrE92CnhFhiz7mvTRVxHxDxGvlBawTQv47Z9KH5slnO3nraVC2QWo97czXYsMlwHbk89ngLCX+2BnPEiMlqfKXi5CGPB9GRifXR
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE3PR04MB8921.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(42112799006)(1800799024)(38070700021)(18002099003)(11063799006)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?v79oQKiCCkLa2oiLMdx/+blaNcMPfTZfk0o0p0W93l12IbgrNkuflHLcIm?=
 =?iso-8859-1?Q?iAoHnCvt97d2yxMwciFGQvg+TAaBWI2pEi7NfH/J+qNzpnqtNKQKQVh5sG?=
 =?iso-8859-1?Q?h+UNg1qQYbjo2W6xxEb/1oQxK6gPLf6fQhjM4BFE9a3WBkgRMCGKhqddVa?=
 =?iso-8859-1?Q?PQlx6Kw3tU+lFMnlmFFER3HFBnItjByzPbJnkDAreZ/ytuHkH9mKkwM9ZK?=
 =?iso-8859-1?Q?XhWXU/7csMBnxULa0Y69FGFVQE0rCkHpBScRDVGgY+LQD49UJwBMxm9+v8?=
 =?iso-8859-1?Q?qlKYv/GTxgPZzez0MEKUYXTJqmDMqbBmmJ3RroqIkVxVNjHkhPFTlG9vkc?=
 =?iso-8859-1?Q?Xxhfc6GtnidVOQDddTAZfPcGMjsrBoxQD7u7LI+D6jAqrAYzS7DcJPtpq9?=
 =?iso-8859-1?Q?Djwj1GunX1oni3++GANoRLi8cchgI3d/eCuU8VfQsHkNHU9czW5pJNz4xO?=
 =?iso-8859-1?Q?X9PvUbinPX1caVAf4xxj5r7HvxGQbpIA8EV7lEIny5kPAF+emHLU0NvH6B?=
 =?iso-8859-1?Q?pUZP1maQOvdYHkjkdDv0nrXNHK+MD5Yz1pmawuIVpyHrw4lLGZMqUu8ZS3?=
 =?iso-8859-1?Q?DWc2pyHWB9RySVf53uDAVEY5LYH15ZHt+nI2bZY/j+5ycxTkkMF8A5/8iC?=
 =?iso-8859-1?Q?seuJCHH3ZVPiEp1zkmrLG6FGK/aaiAnhJJQX1iwoodJHo/oFSEbjJcIdpE?=
 =?iso-8859-1?Q?pdsRZ25LJI4BNMUWvQCCIkzxXDz0MfRPha66ZzAU1zXkY5fKzdwZiczzAO?=
 =?iso-8859-1?Q?O3wbN1+V0yUYWNiQ4uTEhh1YBr7W6Yn1Zb25L+Xs4Qi3M+3BKkNlVvWAYB?=
 =?iso-8859-1?Q?TBmKGTPOu9zd5V+XCTXogT8T6kEk7G3PImx+39EdkQWF9FXfLMSjxgzATS?=
 =?iso-8859-1?Q?xrvUq9EUsdRJQewAQZqFk8zhwK+9UcIyMXKAtvix1W6kjQjFlnA5QOBEIH?=
 =?iso-8859-1?Q?F37PHxrGVoycKjYbraLcPeWS1XEW2mSBBZfwzP0IXEtjyIgvbBBjAbka7q?=
 =?iso-8859-1?Q?u3/mDZ3IKL//2RlneTvvHry5kJFk0CRjbYkz3gXNNqlSIEO1q5ZnYRHwhI?=
 =?iso-8859-1?Q?dNAOZGEMXX2lKmIo8ulqR06k7ZFM2CpJUbte+yHBBSCrKEUZ/WzGSIijSN?=
 =?iso-8859-1?Q?jquZsv1caeL6hrAvaC7XM+GskS9Oar2fxP46/84JyVn1PKUPrfRtUHKWMq?=
 =?iso-8859-1?Q?bkWRXO1mVSTpSOV1h5hlULagpllWLo3Sk15yiPk+NTyofjMxFlL5L0Zet+?=
 =?iso-8859-1?Q?DeFFPDDJjCnO8Y/n/OYZuq7nNRHhUn7Lz4V9T5jNvmPtdQN3Vl96MQYC1j?=
 =?iso-8859-1?Q?FBC99FIcqD4px6riDqEahmttbhyLMrW3j8ob4L1GUM6dBNI6KR1D2GQpuM?=
 =?iso-8859-1?Q?sP8VYsO2bOFGlGcu6HCQWagO6EeVTFEr9dPZcxj8+3QnUdCcgG51+SgNvv?=
 =?iso-8859-1?Q?xuyonWtNr+DLll3+t4xFKMP7M3hUL6+lu9+cOr3Hz4V0t01p18UD2UUIUG?=
 =?iso-8859-1?Q?ZItLmLhuw2QcCYXJdrQo5zVKhZq82o+WydiB0bCnHr9M1gN03cvapPWwpu?=
 =?iso-8859-1?Q?fpokawzF9l6TyId7Va66sbjZshfER1daRVoKsPDtP7oZ4kGVAkGvG+1R01?=
 =?iso-8859-1?Q?2hWjyNyMGTWeRLKrUMgdYMoPfPQHtbidaRChj6kM7+E7aADrpVJ5X5DGd3?=
 =?iso-8859-1?Q?6NKEhpdQR3L3hI8mP6d6Go/y4Ol6zgAP/WAo9nEQYleYNxO7W4/BetEclN?=
 =?iso-8859-1?Q?KOJhz3H7jcbzUqtKzPdEGgxOWSm2LntU93xx+QwqqaIaYYpryLDVvXbAnz?=
 =?iso-8859-1?Q?iLi4L0xfwg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: transsion.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8921.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c4e5d50-7f3a-4d6d-d905-08deb6dba0e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2026 01:52:34.6940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PZZwlTGdPWhoT0FH34hcDdU9+mNU3QihQ0ZFt4bvyl9Jn+Hkq9vn3XAll9wh+MSH6FmBklhpSDzWdGXpVlu5mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPFED9C01C26

From: Ao Sun <ao.sun@transsion.com>=0A=
=0A=
The events/ prefix should be removed, since synthetic_events=0A=
is now directly under the tracing root directory.=0A=
=0A=
Signed-off-by: Ao Sun <ao.sun@transsion.com>=0A=
---=0A=
 kernel/trace/trace.c | 2 +-=0A=
 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c=0A=
index 6eb4d3097a4d..5dd4a8ca7586 100644=0A=
--- a/kernel/trace/trace.c=0A=
+++ b/kernel/trace/trace.c=0A=
@@ -4474,7 +4474,7 @@ static const char readme_msg[] =3D=0A=
 	"\t        snapshot()                           - snapshot the trace buff=
er\n\n"=0A=
 #endif=0A=
 #ifdef CONFIG_SYNTH_EVENTS=0A=
-	"  events/synthetic_events\t- Create/append/remove/show synthetic events\=
n"=0A=
+	"  synthetic_events\t- Create/append/remove/show synthetic events\n"=0A=
 	"\t  Write into this file to define/undefine new synthetic events.\n"=0A=
 	"\t     example: echo 'myevent u64 lat; char name[]; long[] stack' >> syn=
thetic_events\n"=0A=
 #endif=0A=
-- =0A=
2.34.1=0A=
=0A=
