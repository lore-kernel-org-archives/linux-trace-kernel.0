Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FFC4DAFB5;
	Mon, 28 Sep 2026 14:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790605170; cv=none; b=A07r8nNVDWMXRon8bdxvZ8njlV8jmebrn3ssEjChxtScdT2Xf4g/mB6O3pZCVSgCk8M9MkkllVWS+mE1i8LIpbKtPjQlJE4VLU+RpPMGFk8Mg1UGn1h3P9nM9KU5C2cC06WfLaIBe4+cMrDbKIyX/2OCngpQOB2nJ6eY7zj219U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790605170; c=relaxed/simple;
	bh=kMPws3DmqsvCg05hs4fveBqAzjBYVJp8kMdNJmPQVGA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N/O5olcLJJP7yaE2a5DeBiYvF/j/o42jNaCU0UOzUg4F9F65Wsd8nuazNPFZDkIYbqP3ZM4kqcfG9WcLi0hmuUxnQDlRFnG4SzdfsjG/DgLbwcBpd2gT/RvVHCzkQFyqSr2EZ2wtDFDlJzFEeit27gAe9g5IuM8ACVEMaq7w5s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=lkYKd66C; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="lkYKd66C"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=1HIHic1e07cJlsjdHQI93QJFXAzvnsuYhE7/gvB5xkA=;
	t=1790605167; x=1791814767; b=lkYKd66C9H7KlYWraxZP9O+bTRzk0NuPQVj35aIzfUACYOS
	R0TCZIF9CEqq3ui1dS6etEKHYxxIXuU39M1P5FFYdAaSIrag+lFEDa5UDyy+NI3uZuXc2C43EeVxz
	0x9ZyK3Ydgpy5sauL7CNxcBPwqF0TarPMj11GdRXFHg8LxheqR71d6kOSlXsDxIkaTZSVkjsluR7Y
	DWIrqMfyBEvzPUdrwOSFL6E2lK83P9bVGkraJ6u9jyHitYjEUBPaFHEE+mUOzgiqZ2V+QzZk3FyOj
	N145TeGJ318BJlHQeNTdtHmJJRLxusAwWcq8no1xTpoLWVt9JRReMI7nJu5GC9bA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1xBCCP-0000000DcZz-14UD;
	Mon, 28 Sep 2026 16:19:21 +0200
Message-ID: <2f552b80cb4a88f52bf7df70a7766460f4fc1628.camel@sipsolutions.net>
Subject: Re: [PATCH v7 1/4] tracing: add __print_sym() to replace
 __print_symbolic()
From: Johannes Berg <johannes@sipsolutions.net>
To: sashiko-reviews@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org
Date: Mon, 28 Sep 2026 16:19:20 +0200
In-Reply-To: <20260923111017.F17CD1F000FF@smtp.kernel.org>
References: <20260922110955.363677-6-johannes@sipsolutions.net>
	 <20260922110955.363677-7-johannes@sipsolutions.net>
	 <20260923111017.F17CD1F000FF@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2026-09-23 at 11:10 +0000, sashiko-bot@kernel.org wrote:
> > +#undef __print_sym
> > +#define __print_sym(value, symbol_id)	__print_sym(value:symbol_id)
>=20
> [Severity: Medium]
> Does this delimiter choice in the __print_sym() macro in
> include/trace/stages/stage7_class_define.h cause issues for arbitrary C
> expressions?
>=20
> This macro transforms the arguments into a string format using a delimite=
r (:)
> that is unsafe for arbitrary C expressions if parsed left-to-right. If a
> kernel developer uses an expression containing a colon (such as a ternary
> operator like a ? b : c) as the value argument, it seems the string
> representation will contain multiple colons.

[snip]


Technically, yes, but I think it's implausible to have a ternary for
printing a simple enum value *inside* the TP_printk(). You'd usually
want to store the result of the ternary via TP_fast_assign(), I'd think.

> Could a backward search for ':' from the closing parenthesis safely isola=
te
> the symbol ID?

Technically? But it'd be relatively more complicated, the code would
have to pre-parse to the end and we have seq_put() here etc.

I'm not convinced it's worth doing.

johannes
