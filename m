Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021073.outbound.protection.outlook.com [52.101.100.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69613B100A;
	Mon, 10 Aug 2026 10:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786358518; cv=fail; b=IJlXzY19Ql0aoxNgNO/gyAbzJ8HPs9ZvyDJFWQeljDrhYynmDOQvAgx1e/7pbe3HFLAG7yX5yNNWyvx8rp4m+p2Ii3g1qGN+L674eJrNfUDJcWbqm58pk5Gvwxf0nFhQ+T4vFTUVf9N7Hqb05jM9Zs8aQzvw4t6GqG56EghUY2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786358518; c=relaxed/simple;
	bh=dg7nD1xVsjWHjUwovPbdM2xy5O7uF6lg0emGsIoA3t8=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=DOZP6s1fZIfilUaB0mfKCsM7B9UD6cXL18JjMlNaBwTMZFnEpA3XbmQ+AP5YUR6mMkPpgA0jkf+5s/JvbpNWCS+Wf4Y0IPxjE/UE7qz/PWA0hIAUfMdCM7b6/5gv3mAABpw9UVz1S99HLFPgeBeGtbSUKvSD/2J/+A0sIbsdeX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=sdj8Irqn; arc=fail smtp.client-ip=52.101.100.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="sdj8Irqn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ExsVhWz8vGr+sjC/xGbobRHJqIGEiA0s5OGrGdmDGJDN7WRjGZAS2d9cgDcfMtt1eC/gSmGwDJShNPLZ6Ca3L02CVwCED7WjM3SiIJrJty5aKEoQM/fPlAYQ6v9PHtg0aHIkiefurdWUTnX03+ST3zj6jRS7W169mKLxyfTE09OyHz6BpA/a2Qjvq71yX+TNvIBuE6NtYMTY7TVOUdQiXWTLz+AiQJPElUMdgGffvDEZO2YTlf2b4qB50Z7Fw9tAyHMrvwobn2JSQELmlbvrShsP2WzB1GAxfx/1+DsXo8iiJuaFNOPkq+C/Sc5n6TY2xV1wIguojOsBK5UoLhOi5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZX7zctSpkP9/pOq/N/uXZeNBa+UYsLFrp2d/Pe5Hmc=;
 b=gBz9Fe17IOktQ5h1BWMSpRh80uknIjhMfW+gO4dYIij7gOw7oBfJlC2bz96/rFqTpDWRwAKbFI++cG39fi5cf1ELwX1LhM2zIVefTQUaaWuZlBQgRFQ4v1Y65Q8R0esrtRKSDxZxhOumwCXnK1lA32ROATm4cxGlqmOFXKxCbI3Lk/4CWsqYycfmu3rbmruSvYUqsA9LGBU9buAxKnaWNxi5nYVPqs2GlGgasrIcYERYwp8WGqX6poHFPLguajEA1girogM0gs7rPAWsmZfTLHHogDPxmjMZ2PwQWdGAfmbRggLLLxhxMVHRDwQ+pH2QAKEcdTQ1zfe1zTjRqb7wYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZX7zctSpkP9/pOq/N/uXZeNBa+UYsLFrp2d/Pe5Hmc=;
 b=sdj8Irqnffb6xVFcw+egKdWAXYKAV8NWzw8KkasC/Jf4WoSPaff5Y+0V/abPtv5cPpGsTBpwboU1JNpiVMG264PieC5+o0jXy5uJ6fpUhHEkGuT57NBgJkDVUu+g6ZJ8HtF4WDbUPZaRiosifO/Tk+dduf/KWR9nQUapmXNbxrE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO7P265MB7544.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:41c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 10:41:49 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 10:41:49 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Aug 2026 11:41:48 +0100
Message-Id: <DKL78PUDAC7Q.SHSLAX51OP1O@garyguo.net>
Subject: Re: [PATCH v1] rust: add mark_used macro
From: "Gary Guo" <gary@garyguo.net>
To: "FUJITA Tomonori" <tomo@flapping.org>, <aliceryhl@google.com>,
 <ojeda@kernel.org>, <rostedt@goodmis.org>
Cc: <a.hindborg@kernel.org>, <acourbot@nvidia.com>,
 <bjorn3_gh@protonmail.com>, <boqun@kernel.org>, <dakr@kernel.org>,
 <daniel.almeida@collabora.com>, <gary@garyguo.net>, <lossin@kernel.org>,
 <mathieu.desnoyers@efficios.com>, <mhiramat@kernel.org>,
 <tamird@kernel.org>, <tmgross@umich.edu>, <work@onurozkan.dev>,
 <linux-trace-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "FUJITA Tomonori" <fujita.tomonori@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260810075144.1245761-1-tomo@flapping.org>
In-Reply-To: <20260810075144.1245761-1-tomo@flapping.org>
X-ClientProxiedBy: LO4P123CA0051.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::20) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO7P265MB7544:EE_
X-MS-Office365-Filtering-Correlation-Id: 77fa89a7-1835-42e0-b76b-08def6cbfba4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003|23010399003|22082099003|18002099003|10067099003|56012099006|5023799004|6133799003;
X-Microsoft-Antispam-Message-Info:
	mS/a9Z15qqlC7mIl2eHyj9A2zxftXWpIWKfLfJ1VFutZTAdnTQ/ykKoFBpJ7OOY3mtkY5zqSJLxemVEUtMgTuTZzfB7q8Ax3c58v0xvGh6oga1YdjCvPzuT6sjYKnhbhx6W5SNUNtp9KjiQawiapZlKD2NBaI6B3MH4DzBOPlrKu/JJ3N5hs/6GWAGVFL4rE9AT/JVgiwP8m8D3cBWA6no3dgjyW/an6GnCv19MM2bjrbRXhcMX+hOGY/fOXmMlAwnevkpHv8UYMkTZUd5NLISbOH9Z0z+g4rOc9KirYp5JpfVSMGnR+iJJSyE6ia+5v3QQurdDGB8F7fcMST2uXZFsTxKf5YhHjP5jtKZi2czAklMW0VvBmoqywn/KJ6uq5WuZvAlDU+0UZsW1mbn1IFuwBGFOiOtqstVupdVRWsZLmLY87S092nYXsj49sL46g0R7TGj5FsBUzNlWgs/lJ4DfGbgK5z/0FaI5GPr6tg8I8FIw9BLq93Ixwy9Nit3akCdKmf8exKNRKTMDaBMvRWI/kbKBDpj3D3kbVVPyaetQlZ+0ut0MOyG8nYtizxZbnZkoMM5WPsP8dEdeL9K5/3cot/sjbzhS1SUVqypGEoENDgiyqBgneJ24QrGFW7+lSctSRAQwztq3kABHKO5ysP4Hgd4988dqwr/BcjVSIoNI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003)(23010399003)(22082099003)(18002099003)(10067099003)(56012099006)(5023799004)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1hiQUk5NTl0eitKMDBBbnp2azNjb3JkQmEzU2pWS0xzUXFoSjVmRmhROUdw?=
 =?utf-8?B?bXpma1VuWW5ibHV0QUNLWCtLOVk2WUN5Q0pnNDgwbXJsQ0JCYzdmMlFLTHp3?=
 =?utf-8?B?Z1VaV2V6d2RWVG5vejQ1ZFpzMHloVXdEeEpleENpUnpQS3ZOMnNNVnBxa1Ft?=
 =?utf-8?B?ZGRhSTlIYWtEcnlaSnloWHFCd0tUa1JFeGFwR1lLd3Z4S081MU5jV0xrYkd0?=
 =?utf-8?B?UVYxOWVtamhZUjdvSWNyYmJLTitFaEEzZHFhb0ozOEtEZ3JsOW0wcGdWU3Vy?=
 =?utf-8?B?R1duYnlTK2VzM0RVY3Q1L082VTZDVnBBZTlRdzU4eitLaVZVMndjMDdTRjRH?=
 =?utf-8?B?cldYRmIwRTlkS2xBb05DaWpnbFdtK3Qrd3UraTBwVnVUeUpOcjc1Y0dIcStU?=
 =?utf-8?B?SlV6MDVZSy8wcXJTTzB0TjVKeGpqdjdiUHNOVFZQdW1pOXhLZmJKdHVEdHlF?=
 =?utf-8?B?Qk9aQTV2a0dDTk9aSXZFVHRTN3VyWGYvWW4rRDIvcW9GTlM5ZW82UUlYQ09T?=
 =?utf-8?B?QWY3R1VoMWJldXBWSG9WOU5FS1h4Ums2eS9aZnRRekJvTnF5TUg3bStmYlNF?=
 =?utf-8?B?a2xQVlZaVTBRaWhQYUFhU0JrNXZtZGQwU3NTQ2huY1YvOGk1R1NZdVpLS0ZI?=
 =?utf-8?B?czNFanRReExMT2ZoYnJRWmZ2YjQ2dENLbHdwZmIvMTZLYXNiZzR3N1F4UHdX?=
 =?utf-8?B?cjZOUEZsbGdESU9vNHpKd0RhT0wxRk1XRjRxWS8rVllkeUl4cjdkY2JxS3lq?=
 =?utf-8?B?WWJrbVNBekJyMndIUFgvc1ZHS3lPRllTOG1XV2xMMjFXdVdJK09xOUNJaEF0?=
 =?utf-8?B?eDZuWFh0ckRORmlXL1NuQ1RYbmFDQW94dGJNRE9pTXBBM1IyNWJTWTU2c3ls?=
 =?utf-8?B?Sm5yUzZPc3BvYnN3cTNwM0x5OXVrRXNvVGtzSE9CQ0Q2K3kwT3lVMStia0VW?=
 =?utf-8?B?VFFPWUgvZTNnRHhWcXFWUG5oR0ticTB3ajhaTmlnZ2lraDVYdUpaSEVkQTJa?=
 =?utf-8?B?bXZNa1FNWUo1QU5MZW52L2ViT0ZhOEJpMW1pNTF3THlVdlZndG9SSWFDL25K?=
 =?utf-8?B?RTFuMTRqMmhmZkRnejJ3dE11SXluaVJDL09VbzJCd0wvTGtiSmE1QWZSWGYr?=
 =?utf-8?B?VFlhSFJLRFRSUEZIeE52bFUvREx1cm1LU1pRNDN6RGxHMzlqWkhoOGNXbmdl?=
 =?utf-8?B?K2FXdlc0NGJveFM0Ri93aEQxZm02dlR6OERvNk5DZEdYTjVNMDVpUm9RRWhp?=
 =?utf-8?B?QitwZlA2STloWEUwUkRPdzBTOE1xUWprV095WGZ5eG8zNStsU3dDd3FxN2R4?=
 =?utf-8?B?OER4L0RPa245bXpPbTFTMGt6eTRnRnl1dnZvaGJuVG1aQjhTdzQ2VmVjbkhv?=
 =?utf-8?B?d0VXZno4MHpJUzFDNGh2QjNlN1N2MFNtRHlHdWxaaXJXUDBvOXZreGRzWjJW?=
 =?utf-8?B?dzJaV1RxR3B0STFLRi9zaUgyckNUdGE2NkFvMmFUb3ZoeEVMNDkzbHEyWFFJ?=
 =?utf-8?B?OWhzR0g2eVN4WkdzSHMxZHA2T2pRQ2xxd08ySzNFbnpQSFd3amhqSHZqaVZt?=
 =?utf-8?B?b2lqUnZneHIweW8vZkVPN0hRR2FYOUFEMENONEJndjZQMEttU1BrNmp6UFg1?=
 =?utf-8?B?dXFvNjBHYW8zZE5sS0daUk9Hekk0N1JpaGxnSy93YWVnRERBSkFVQWFNNDNt?=
 =?utf-8?B?YTVBL0JmbjMycEw3TVNyYzFZNnpjK1dlS3NGdDdWUWlzdlFxNWVTd1hZQVdQ?=
 =?utf-8?B?ZWtQeXBsTGFET2RsUFVkZkZVaXhzUVAwaXJVeTBrQzF2SktQTUtrYTZhQ1Ey?=
 =?utf-8?B?L3Robjd6OXBGcjZ2OEN4ZHIyU3RxYVI3cU03cEZzS1dFcUNmRUgvVm9xUzBR?=
 =?utf-8?B?OWZBeEpoNWRiMjZxZldXSnlYSDR2ZXlUdnByL1pwZDV6Qm9xeFdJek84Q2lF?=
 =?utf-8?B?ak5RWlBteTQxcFpRTEFIYjV2WFZaZnJ5ZFBJdjNYS0JFU2lXOGc5L0hadE5M?=
 =?utf-8?B?cnVzR3hUekVLWmd2SmwwTkxnY2FjOGRjbzFWZS9sRWhVdjNpYTA1bVl5YnRK?=
 =?utf-8?B?U3RsWC9JVXZNbStEYVI4TU9EcW0rd1paVUVhSHVnd3lLdXN3cjJRc2gwWUNF?=
 =?utf-8?B?Qk90dUE3ai9Rb01CNHNJaHlGRTY0S0pINFJPM3NDeC9ZVS9xeWN6TXJDZnBx?=
 =?utf-8?B?SlQwcmZSemV5ZkcvYXZ4MU9WTTIrbzh3ZEVKU1lsUkFlb1RDYkwwQjNUNXNI?=
 =?utf-8?B?QjZ0Qzc0MndxWkhOWW9ydUlra1paWEFwSnU0angwV25BMnZLYS9ORnp1RmVM?=
 =?utf-8?B?cUxWSmtkUENqaHZmZmxhaUFPNkF6VVJJWTdCYVFDYU9VQUoyelZ0Zz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 77fa89a7-1835-42e0-b76b-08def6cbfba4
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 10:41:49.5158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RsWuF+n3l73l08zsyS+VsRlgDYYADz/7yF3gj6yBU6ouAqQNGhfaTiDpvJoUKIAf5RqGR4O0M43vBLfbgR3nRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P265MB7544

On Mon Aug 10, 2026 at 8:51 AM BST, FUJITA Tomonori wrote:
> From: FUJITA Tomonori <fujita.tomonori@gmail.com>
>
> Macros whose expansion depends on the kernel configuration end up
> ignoring some of their arguments, resulting in unused warnings.
>
> Add a macro for the `if false { _ =3D ...; }` idiom used to avoid them,
> and convert the existing open-coded users in `warn_flags!` and
> `declare_trace!`.
>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/bug.rs        | 18 ++++--------------
>  rust/kernel/lib.rs        | 12 ++++++++++++
>  rust/kernel/tracepoint.rs |  5 ++---
>  3 files changed, 18 insertions(+), 17 deletions(-)
>
> diff --git a/rust/kernel/bug.rs b/rust/kernel/bug.rs
> index 3566f0234ca4..c1e4eb7d4a70 100644
> --- a/rust/kernel/bug.rs
> +++ b/rust/kernel/bug.rs
> @@ -55,9 +55,7 @@ macro_rules! warn_flags {
>      ($file:expr, $flags:expr) =3D> {
>          const FLAGS: u32 =3D $crate::bindings::BUGFLAG_WARNING | $flags;
> =20
> -        if false {
> -            _ =3D $file;
> -        }
> +        $crate::mark_used!($file);
> =20
>          // SAFETY:
>          // - `flags` and `size` are all compile-time constants, preventi=
ng
> @@ -83,9 +81,7 @@ macro_rules! warn_flags {
>  #[cfg(all(CONFIG_BUG, CONFIG_UML))]
>  macro_rules! warn_flags {
>      ($file:expr, $flags:expr) =3D> {
> -        if false {
> -            _ =3D $file;
> -        }
> +        $crate::mark_used!($file);
> =20
>          // SAFETY: It is always safe to call `warn_slowpath_fmt()`
>          // with a valid null-terminated string.
> @@ -106,10 +102,7 @@ macro_rules! warn_flags {
>  #[cfg(all(CONFIG_BUG, any(CONFIG_LOONGARCH, CONFIG_ARM)))]
>  macro_rules! warn_flags {
>      ($file:expr, $flags:expr) =3D> {
> -        if false {
> -            _ =3D $file;
> -            _ =3D $flags;
> -        }
> +        $crate::mark_used!($file, $flags);
> =20
>          // SAFETY: It is always safe to call `WARN_ON()`.
>          unsafe { $crate::bindings::WARN_ON(true) }
> @@ -121,10 +114,7 @@ macro_rules! warn_flags {
>  #[cfg(any(testlib, not(CONFIG_BUG)))]
>  macro_rules! warn_flags {
>      ($file:expr, $flags:expr) =3D> {
> -        if false {
> -            _ =3D $file;
> -            _ =3D $flags;
> -        }
> +        $crate::mark_used!($file, $flags);
>      };
>  }
> =20
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 9512af7156df..2f770d80bd8a 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -266,6 +266,18 @@ macro_rules! container_of {
>  #[doc(hidden)]
>  pub fn assert_same_type<T>(_: T, _: T) {}
> =20
> +/// Marks the given expressions as used.
> +///
> +/// This avoids "unused" warnings in kernel configurations that do not o=
therwise use them.
> +#[macro_export]
> +macro_rules! mark_used {
> +    ($($e:expr),* $(,)?) =3D> {
> +        if false {
> +            $( _ =3D $e; )*
> +        }
> +    };
> +}
> +
>  /// Helper for `.rs.S` files.
>  #[doc(hidden)]
>  #[macro_export]
> diff --git a/rust/kernel/tracepoint.rs b/rust/kernel/tracepoint.rs
> index c6e80aa99e8e..cb06fec4c4d9 100644
> --- a/rust/kernel/tracepoint.rs
> +++ b/rust/kernel/tracepoint.rs
> @@ -38,9 +38,8 @@ macro_rules! declare_trace {
> =20
>              #[cfg(not(CONFIG_TRACEPOINTS))]
>              {
> -                // If tracepoints are disabled, insert a trivial use of =
each argument
> -                // to avoid unused argument warnings.
> -                $( let _unused =3D $argname; )*
> +                // If tracepoints are disabled, the arguments are unused=
.

nit: the comment seems redundant now that the macro name is self-documentin=
g.

Best,
Gary

> +                $crate::mark_used!($($argname),*);
>              }
>          }
>      )*}
>
> base-commit: d8973c47544371613313ecb9a8c3e7b244aa9bbf


