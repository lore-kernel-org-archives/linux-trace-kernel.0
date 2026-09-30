Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61899377AA2;
	Wed, 30 Sep 2026 09:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790761841; cv=none; b=V7hjJk3Nar5sPlDGJwDeIsqNNtCqWVRegaYCvHZnLGlRqIfLHkGfEfw4Jv4MvN1LUPPjBP6Chab2zVHFYXgnbCjA/Hwboawu/jGibwEvH6LLHGBDaxeHifqRfzdwHjRjR6zGksmp2QtKz59ceLfJnwCK2abW1+y0JCbpkZvafuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790761841; c=relaxed/simple;
	bh=tuwSgWJL22ArBwU4UcI419HlJIo9ztH6zqLRLzbmm3k=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GmGX+Sd6Fqc045zy2YbF+nihaNHyPY9jfiq04/vMitHGmCinCKFh9JqrJbOFlBP5vy9+y6TiQ+BxKvITwmxP7lnyNVRQlBzq724lzL6dk7nBd8ujLzyWQgBGiKEdKvzKtY5t8bnTLwfn4xqvlT+amnPj+TDFqlPj+e1Bs2WRcjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flapping.org; spf=pass smtp.mailfrom=flapping.org; dkim=pass (2048-bit key) header.d=flapping.org header.i=@flapping.org header.b=LwzUvtVH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mahjX47m; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flapping.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flapping.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flapping.org header.i=@flapping.org header.b="LwzUvtVH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mahjX47m"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id B79311D00776;
	Wed, 30 Sep 2026 05:50:35 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 30 Sep 2026 05:50:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flapping.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790761835;
	 x=1790848235; bh=xTi8mkd2hKq0XvhnI+g21LmIyAy+JclsTvAvEFOKhvY=; b=
	LwzUvtVHb54qyu4QA+qq7hUcwR6eSpQfrbpuMh+czmI2SF2qwGC21Pg9C5bU/UNy
	vQkCr9zx0KmTnIBxdWjxUXJiwXsY/ira+0raiXJUw9v6R/7xI6S0AK7cot9QjHkj
	A4SjUv1bWWyAAlqnTIhLlD/esyByDt0zZCpSxnkg9tKAySDuyrG1Jh5pgveMdOeS
	lwf/u9nO+NyKvtH+IRU5i9IE6mCJUwhQ443198CycfcCH1P3Vy2HRChs2lu0iCrW
	F0yfPY/RE+js3/SPSnWteOVHDMjOWrL+M/9r+uuoJjOPaqXICp8LAUIBQJC9DHUb
	kzsr1uIPgt7iYTAxs+yp0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790761835; x=
	1790848235; bh=xTi8mkd2hKq0XvhnI+g21LmIyAy+JclsTvAvEFOKhvY=; b=m
	ahjX47mtwUFZGVoLz8nYA2ot3K++E3CoPafAC6Zi4AjhusODVg/oXfz9xPCAydnF
	f1ZSW3Xy6zmiB/NwGe6v4KlUNRA0OZT4ZAw7OjJleva375lKsfK4BQ6GZa+6xKR3
	6T0iE9PQNpzmOpkSgSyZAAYWxS9OhQdKIvrcCRXcNWGztlDWIWPJ8Gy1AWyoeQGz
	Sc6vjcJyCUJYp4pvC99aUSPNR7PiNxaHEhh79XRCgrfOx+Wk0dOfqHTUtNDP5v/Z
	QtREv5Hb1zsFrftwsdLovPH6FfnzxlvZUdlnWPpEa+bodAIqGjRqXp/YhAKcZdaA
	o3Rw+yiZ/PwhlG9OItLXg==
X-ME-Sender: <xms:atu8alSBEFmUOqlzOOIVQV-mSeOhEftykP2Mx1x0bufL7qKu5avWIw>
    <xme:atu8agIgwzNuF5ymrJClJxOhXkhfuTW-8iex8caz9kJrrnkXxFK0r4fOQRZaGyZJ0
    irqIMruXLajO1ymAOIxm3DqZ4DYtbl-602OgBka4VdAEqtaX5_PDudz>
X-ME-Received: <xmr:atu8akEsZTJu7WvdrLD2_CBCFnkOayUSUDDbPpES_mB-fDtJToD7TWcMWmgH5SyriDiERHsU0mqLvAZ1nyfNcOSS>
X-ME-Proxy-Cause: dmFkZTEPevjAlb+2l6b+n7w8y6ujriy+UFZT+PG4r+SW1iAMjlAtCUDNDDd1BCVIAT24Y0
    din4ecsjUhYF3MRG7cB1CVYKNirFyGkqALeoCwMYkYbdWlDzi1O8+s/c1tVQcMVw4V/rcH
    HFE2moN6g0jQ8DlzneyuCDyZkzJotsir/enHPItV5USmdBzul5nkaxRcS7yCSryn1wCKpr
    rIbjWwqG8xsy34AlD7/Rq7jzdzu5Lmt6QuSKIzYsspN2NNI3ZGwT0dXZAXtwiK8JXQDrgO
    IosJYmcM/Ls08V0Yt11ivg7m76N77gT8G/9mbgbaGLMbOp8oPm9jNWedmyNbbaMRzzBDO2
    hvWKnoNxCCMAiiymrLE4uqKjRLqqGttdzCBuAa8WdaZN5QR6GNB2gCojEhExbEaj4D0M8t
    aTbNI9uN+f8IvC0LEEijIKtDrOVmajyPFZBwZrHHwhF34g2bH/mfQWLpin7XpVQXCGsrJU
    cl2HPbL2TyxQMKjn1DcM3GtLVYjSwij19A8eLVck4vMk9Qj+Jl45S0X+Hb91ZV28vEPyZB
    saU2gqTRvSqoalY0N9ZaSjVEF8726E8UgUxwudC/RZFR9Qw9W1AketW5sT7lx39CDHr/mu
    iB50Epw5tgpKzPDlSnI4LYkhwHJvtO1hFbT1qUsLbvWrJSQiY0QNMKvH72Qg
X-ME-Proxy: <xmx:atu8alT0uIjVzY4Ndwy25W7ysdtxt_vJN_RMWEUHgs_nEpPXpn2pVw>
    <xmx:atu8alWJWY0vegNlGPtDtPNTB3tgJmHlBRpDoe9KnNbYfioPuIc7_g>
    <xmx:atu8asg0wQXMF35wJ1UbnYnlml2bPv6OUJVQC9de43HSYHE7HWt7Lw>
    <xmx:atu8amd7_tJgRtXt14Y8cGqcMUHpRBVQkNYe-vMgquDOfRrU0KYmEw>
    <xmx:a9u8alCVrb9Y3_4fFUYqXPKSFY2S1S-HPiemPPq6Sizc3tuGIm2epenj>
Feedback-ID: i51fe4b43:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 05:50:31 -0400 (EDT)
Date: Wed, 30 Sep 2026 18:50:28 +0900 (JST)
Message-Id: <20260930.185028.532667902450882259.tomo@flapping.org>
To: aliceryhl@google.com, rostedt@goodmis.org
Cc: gary@garyguo.net, ojeda@kernel.org, a.hindborg@kernel.org,
 acourbot@nvidia.com, bjorn3_gh@protonmail.com, boqun@kernel.org,
 dakr@kernel.org, daniel.almeida@collabora.com, lossin@kernel.org,
 mathieu.desnoyers@efficios.com, mhiramat@kernel.org, tamird@kernel.org,
 tmgross@umich.edu, work@onurozkan.dev, linux-trace-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, fujita.tomonori@gmail.com
Subject: Re: [PATCH v2] rust: add mark_used macro
From: FUJITA Tomonori <tomo@flapping.org>
In-Reply-To: <20260909120210.2488674-1-tomo@flapping.org>
References: <20260909120210.2488674-1-tomo@flapping.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi Alice, Steven,

On Wed,  9 Sep 2026 21:02:10 +0900
FUJITA Tomonori <tomo@flapping.org> wrote:

> Macros whose expansion depends on the kernel configuration end up
> ignoring some of their arguments, resulting in unused warnings.
> 
> Add a macro for the `if false { _ = ...; }` idiom used to avoid them,
> and convert the existing open-coded users in `warn_flags!` and
> `declare_trace!`.
> 
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
> v2:
> - Drop the comment in `declare_trace!`. The macro name says the same thing.
> - Add Gary's Reviewed-by.
> - Rebase on rust-next.
> v1: https://lore.kernel.org/rust-for-linux/20260810075144.1245761-1-tomo@flapping.org/
> ---
>  rust/kernel/bug.rs        | 18 ++++--------------
>  rust/kernel/lib.rs        | 12 ++++++++++++
>  rust/kernel/tracepoint.rs |  4 +---
>  3 files changed, 17 insertions(+), 17 deletions(-)

(snip)

> diff --git a/rust/kernel/tracepoint.rs b/rust/kernel/tracepoint.rs
> index c6e80aa99e8e..29d2d2d0aca8 100644
> --- a/rust/kernel/tracepoint.rs
> +++ b/rust/kernel/tracepoint.rs
> @@ -38,9 +38,7 @@ macro_rules! declare_trace {
>  
>              #[cfg(not(CONFIG_TRACEPOINTS))]
>              {
> -                // If tracepoints are disabled, insert a trivial use of each argument
> -                // to avoid unused argument warnings.
> -                $( let _unused = $argname; )*
> +                $crate::mark_used!($($argname),*);
>              }
>          }
>      )*}
> 

Gentle ping. Could you take a look at the tracepoint.rs part? If it
looks fine, I think it is easiest to take the patch through the Rust
tree.
