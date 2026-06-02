Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CD73C988D
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Jun 2026 11:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780399131; cv=none; b=J7FkuDiY+0VRtFHNSv8ZLdMcBjgHCAdTmRtCR+1Cz6IX4OGp3K77NMFdXWY8FLV97cOdfTKwDaN6tbNugppweXitO6Mq2LgSr1F8volsT3fCqrcpZB+I9966kQJgHyZ4/12hOBf/KtqFwko0wN960bTjagECDrFLjR91rOm9fF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780399131; c=relaxed/simple;
	bh=Ub+Nq+n5OFIRR6HUN12pWxjqh5p4VKWcRDUrJXwg4eU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=noLmo7oBJ9iubfrfvi2fpOEtidL7p+NqRCI2ab1sVy5tz5BE9IcNYsOAkiYKKs35keze6efMfl8WJqoKQq1qqovqKIw7NdFF6gyNEbwHXfUDWl2pqcuyWel7/agpRfqZe+EthtX1I4B2wYPTy4Vjjwgk5wJrPpPkOpyMLkL00Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yuqgsz9y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yuqgsz9y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780399129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JEUFHUSwCmVYKLEm+PTwRrQ3d7ntv4tRpcxGTQlOp/Y=;
	b=Yuqgsz9yp6WyqdzKhUEUX0smgcjFGNXAnEZ41ybs8nR6MgnqxWpwoVIMe/mRh6AseJ9uno
	JcLA/cw8zuGdgQsff7YXYLI5/EnxKvbGG0jlYzSp/Mmk3GZ8sBaytjTAikwGqfyqUnHCnw
	cD7ZA5UqW3Jr4MtQhYYp6FXBebHiOhU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-bWa_Sh51NBmFqidGHcdA1g-1; Tue, 02 Jun 2026 07:18:48 -0400
X-MC-Unique: bWa_Sh51NBmFqidGHcdA1g-1
X-Mimecast-MFC-AGG-ID: bWa_Sh51NBmFqidGHcdA1g_1780399127
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-bdad545342aso921506566b.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 02 Jun 2026 04:18:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780399127; x=1781003927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JEUFHUSwCmVYKLEm+PTwRrQ3d7ntv4tRpcxGTQlOp/Y=;
        b=H/8Rr4fMX5+/l8sPMqMLQMwj0GEeE8pyJfAy4Ce80tKMObafzLHdHniCWhT1/yI+bs
         GXBJyHpN8pnPyCjq3P7Rd12EmDZmN1SOuy9BfMtVQKUtxvIOhd5B7Mv6PhQIj6VuZpXt
         0AmRz0CYZbyGc7Q9brFhQsw6Sduh8aO+4yrxVeCq4tjaAEfyc5GdcsM/pwm1/5u37N0D
         WqMnuhNaamoTMlEM1ATJAGVLav8IF3i0DXnj1QAr7OidrwdRFxlpsqwaS//Bwo69mDes
         kav4EfkrVgXZrwYxAI1Nf3sDbNbiGxahba6J/7MmMYBbwUV7MtT7xtGwvsRsdF1A1Xwr
         Cc4Q==
X-Forwarded-Encrypted: i=1; AFNElJ+5j5qb9KvfpTPwNsFGqx1IKZM332W94yUi3zgJ9HTq5HrpLDtglG+WiRpijF2PYCrxnKlWmSpn3p1JWtJN1TCaAB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsraPW8quvVfxVp3nD3DHflll/NyCtHe+VVz3HhRrvQE6iRq1N
	oYZL7+ZXBP4l/NVOmk5vIoojtpFK/3EI2RKk7xL1iPB43JF54FIKgt9euAQ6Z5UWXllEU+Oegjr
	d7qi+sMBgyeEUg2B9ki5XhYw2PU9RvTF+5jaMIt28xh4SNJfkszM91J3ciI9l2kLMcBAOUygGA6
	Ut+NhfTof7v/Ln/QX0I+KCI7uasYt8mQf+/65Kfj3iJdrGaJQi
X-Gm-Gg: Acq92OHNQHqGV2S96/jlgM2fNekdP8uq1LWQz9+29bUjb4qDShBKiuOwboWY2nb36lI
	wTswDATutgHS5TlcdTI4f2AaSrZ9S9lMzII++PgPLdLgZ8ESEizFA+21f1/K9DH3XmRUKLWBsfX
	gsjvKxuGWptmAdDgBcM+oG9MNf0SSnIistuRySmWa9G6TFzHl0e6IunbjxA8d+VyHuXqUVhEkVm
	UVPj2Pw8qep+ge8
X-Received: by 2002:a17:907:aae:b0:beb:3783:ac7f with SMTP id a640c23a62f3a-beb3792f39bmr543742966b.46.1780399126594;
        Tue, 02 Jun 2026 04:18:46 -0700 (PDT)
X-Received: by 2002:a17:907:aae:b0:beb:3783:ac7f with SMTP id
 a640c23a62f3a-beb3792f39bmr543741466b.46.1780399126018; Tue, 02 Jun 2026
 04:18:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601211538.381649-1-jkacur@redhat.com>
In-Reply-To: <20260601211538.381649-1-jkacur@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 2 Jun 2026 13:18:35 +0200
X-Gm-Features: AVHnY4LlMBNsmtHk7Xv1kUU79bHrj2NpnwNv55m18nG815VEnLOeOV_wY6UP7FI
Message-ID: <CAP4=nvQSEyCjoaa+Duh-VBJjGTbVd_hNr6kqPyGGAGCUn3viVw@mail.gmail.com>
Subject: Re: [PATCH 1/2] rtla/timerlat: Fix parsing of short options with
 attached arguments
To: John Kacur <jkacur@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, 
	Costa Shulyupin <costa.shul@redhat.com>, Wander Lairson Costa <wander@redhat.com>, 
	Crystal Wood <crwood@redhat.com>, "Luis Claudio R . Goncalves" <lgoncalv@redhat.com>, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hBDH9Jg0BBGnNMyFKys4Uy-UVf7nVzGhRgEGfA-kyng_1780399127
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

po 1. 6. 2026 v 23:15 odes=C3=ADlatel John Kacur <jkacur@redhat.com> napsal=
:
>
> The timerlat hist command fails to parse short options with attached
> numeric arguments (e.g., -p100) due to conflicts between digit characters
> used as option values and numeric arguments to other options.
>
> This issue was discovered when testing rtla 7.1.0-rc6 with rteval,
> which passes arguments in the compact -p100 format. The rteval tests
> failed with the confusing error "no-irq and no-thread set, there is
> nothing to do here" even though neither option was specified.
>
> The root cause is two-fold:
>
> 1. Digit characters ('0'-'9') were used as short option values for
>    long-only options like --no-irq, --no-thread, etc. This caused
>    getopt_auto() to generate an option string like 'a:b:...:u0123456:7:8:=
9'
>    which made getopt treat digits as valid option characters.
>
> 2. The two-phase option parsing approach (alternating calls between
>    common_parse_options() and local option parsing) confused getopt's
>    internal state when encountering arguments like -p100.
>

What actually happens is that the call to getopt_long() in
common_parse_options() does not recognize -p, but it still increments
the internal static variable nextchar by 1 before falling back to
timerlat_hist_parse_args()'s getopt_long(). That means -p is ignored
entirely and timerlat_hist_parse_args() only sees -100.

Note that options are not required to trigger the bug:

$ rtla timerlat hist -nu -c 0 -d 1s
# RTLA timerlat histogram
# Time unit is microseconds (us)
# Duration:   0 00:00:02
(rtla 7.0)

vs:

$ rtla timerlat hist -nu -c 0 -d 1s
rtla timerlat hist -nu -c 0 -d 1s
# RTLA timerlat histogram
# Time unit is nanoseconds (ns)
# Duration:   0 00:00:02
(rtla 6.19)

Again, the nanosecond option gets dropped by the
common_parse_options() mechanism pushing nextchar to 1.

> When a user passed -p100, getopt would incorrectly parse it as three
> separate options: -p, -1, -0, and -0, silently setting no_irq and
> no_thread flags instead of recognizing "100" as the period argument.
>
> The two-phase parsing was introduced in commit 850cd24cb6d6 ("tools/rtla:
> Add common_parse_options()") which first appeared in v7.0-rc1. Prior to
> that commit, -p100 worked correctly. The digit characters as option
> values existed since the original timerlat implementation, but only
> became problematic when combined with the two-phase parsing approach.
>

Note that RTLA documentation only ever mentions the syntax "-p 100".
Nevertheless, this is a real regression, and it's not unreasonable for
users to assume the syntax without the space also works, as is common
for most commands on Un*x, for example, gcc's -I/include/path syntax.

> Fix this by:
>
> 1. Eliminating digit characters from the option string by filtering them
>    out in getopt_auto(). This prevents conflicts with numeric arguments.
>
> 2. Refactoring timerlat_hist_parse_args() to use single-pass option
>    parsing. Instead of alternating between common_parse_options() and
>    local parsing, merge all options (common and local) into a single
>    option table and parse them in one pass. This matches the approach
>    used by cyclictest and other tools.

This is a partial revert of the common_parse_options() patchset [1],
it does fix the bug but only for one tool (timerlat hist).
getopt_long()'s design does not allow the user to reset its internal
nextchar variable; it can be reset (by calling it with optind =3D 0, not
1 as the documentation says) but that would require a lot of work, as
we'd have to calculate and restore the original nextchar. It might be
the easiest to revert the entire consolidation patchset [1], if that's
worth it.

[1] https://lore.kernel.org/linux-trace-kernel/20251209100047.2692515-1-cos=
ta.shul@redhat.com/T/#u

<truncated>



Tomas

