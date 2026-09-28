Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F2F4D5996
	for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Sep 2026 16:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790611967; cv=pass; b=LMK8jdYDfakUSibmc0WLqfPxAZ+UQ8PAL8KTpuFJHRhFlqnZY2C01OUxn1IlN+kkY1KHN5mIViaXhCbWsNqMp2yObUEjTkfry8Mykzi60vOV+ubp1b3lsUeX1oYxybFsLZZ05AYSTqZKRESy3vqpOkZxbbsMKUWypyqlkmnDbQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790611967; c=relaxed/simple;
	bh=9/5n3y53FjTjhvHDgz6T1mo7PBjDtEFNf/o3yogF9pU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XLbiJbb6bO1hHxeZ1W4tl11hIwML/x8gk3/nx+cwdqcNwXJqzn7JNIF8uDxo61F8lh0d4/V4xWb9EqCC1DDAuOK6DT3YMMea0x4o/nOJFqVMSMVbAWGMcS4gWkp9/86f9sXKJBUW0TlgHZ8ySQ4rcyfVJFT4o5a31xJEjQis0Js=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=okkzBXfy; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="okkzBXfy"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5333401e359so328441cf.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Sep 2026 09:12:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790611965; cv=none;
        d=google.com; s=arc-20260327;
        b=KcfOWbiV6uQ5UgKaqcsg5U7sYm93tJRH3UfTSqYA1rXwy5ZPZ4r+GhLmQOteypUjSZ
         E3qEdklBLMCl3jTMfpHIkpoNirVP4ErzBxqnTItZDfXDrMy5JlaNOtcaSgk/z+ZlZsGy
         bJSJKxAL5VbQaSZigOMGTgK8/8LoCJynZVQAFUHe52n4CC9BHUlgDAi8Zi4i/ggiDQES
         KWhh1Pd6lmJpfg8mZMwi6EUTcY5YbroCF3Zvhe2fGtqainG73YL4+urHa7CjXcxSTxd7
         enV0TTIFfRt2UQ7Y45MnBA9Wr/yfK15RptI9Kz8BsTI7W2qBD1huuWZ6ETx6waOUnrrT
         SmXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jtwl90z0UN3pnLPH3ZZJ2kXHY9taouCeQz8eAktVkic=;
        fh=+rgtZ7VWe7SkZZOtecu0JTQWiEfdlDxXZ98eiGX1Ovs=;
        b=X2dw2g9KgaPyimUe3mcdbmZE0DugwYRCh/59KcgGI1IBzhsUUW5uEwP+Raie0bIGl3
         /9GK949Xwsc/o+swzSNoIQvJus2UtvNkIp8snq+JOKZImr7dQ6KZFehxd58QGNihofoX
         9VitIS+BnaaC3IYoxfESZVayx1R8q72uMcxKS/9LClK12h4Zf0AMZlcdol0HzQ+8CM3y
         hUrxzjb8gigRgcBU6l4NWYSO3qwsyIxKLYfJx0f4rUps10iXKwGLspE9awYHpYHBEPGN
         fIx4yYI/cgZKy57zoBOHVneUzUGY44ucedld/jDGRTW8YJdN5+LxHLJTefDY6pxLSJDk
         50UA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790611965; x=1791216765; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jtwl90z0UN3pnLPH3ZZJ2kXHY9taouCeQz8eAktVkic=;
        b=okkzBXfyQv35uAZrtHPHqBW3PC7h0eVzWHWawTsU4QHNvped9XBMWEO3NpaxHmItcd
         IN4R1+OSKzKVbR6u4UEdNX81eQ0Hul8fFItGZzIQtl5UMgtbFLsJUXOsHvKr8Nt7voMC
         U+FRviuPLHDkRUidQ+bpFsuPdaWnl75xgAIrWzQcnfI5LcinqGNXncakofS3+3LZtNF3
         zHKExFVPPzAzDwCzs15d1mFOSKYeQUtGdejIdXNACnPLEyomtaXMKD+93lQ39KUGRnBN
         ceXb2avTlINqlPN2XlIvQFoL9tldE4CMNK23P5tws/UcLczSuw6H4pNmLnDH14CKBSx/
         KD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790611965; x=1791216765;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jtwl90z0UN3pnLPH3ZZJ2kXHY9taouCeQz8eAktVkic=;
        b=PkAZgBRF/jZ3dPi9E5dpAtIDsZvliTdv9CUWUgkdjUIHVPNU0B0ZVSX/QeemxDbmQb
         biJq4nsV5Be+cf0d441ECiXItP7UYAMCH9U0uz2nHkCPPkPCpOzXWh9Y8uUeEOHnxNCv
         Jovwh/A2nS0RHdJj0WT4KJn1Y2ooh8+PuCjMNGgPVpmerHT3ZBIVjJnNu93gMmUtHO/j
         iar5P9OTMt7yxoakFdQ6ADoTk66BYfexbA1wzUznQganfXoB/axCovgfteP+TqQFd/Jh
         PdrjhRnAVuJYBzzl5r3Bz0d/ydk2B916dysraZxeRUKOY35QVLlY/GJe58TKCzBX0WKJ
         xnDw==
X-Forwarded-Encrypted: i=1; AKwUvByD6ZBhacxjprkl68WoyV1XJX1Kt/UP4DxgUQoBIjmvhOXq9rFk1vAFlHkeYGgCTnreba5k1xf4FwJkmLwwp5ow3WE=@vger.kernel.org
X-Gm-Message-State: AFuF++lNOSGQXxnu+W+Sp3v3eYXMD5ZnvTdn32qoxpFL0dLPc0jNHYIW
	wG611Wi96Ard64emy8GEG2Uw+V14KGj7s+uIK6wJ9H61JNqcLG9trtE7Og3gh8QuK+teg2PjM21
	SH6edzS7s2ISPMrjCg4wLhRxJgtOQAQ+ATnjhgBWs
X-Gm-Gg: AYBFou1Gzj/2fZAoXbOOanL6ecorH9njmhN/9ON8ZDEP1SI3n6aLa+082nP90UQxWpV
	26N9Oc44NyJLlGIOLVUrlA5rQDof1jE09XvHIuLWqFZ9EuSLnnVEaQ0uyIrBMHmUSBDr8Mjg2iL
	mb1A/110VKJTtYzWW2plJkzcm0S/2Nzr50wt0oqvJSAp0XP7bzhqIp07gsZRuVW82gP3ZB9SSKa
	BZTcNflzVMN/mjWhAkXPDs3rpiKCtwoIqx3o4JhB9AUsKDk0BYC4pVF+NG74EsKzltUmkVJrx8V
	QUn5yr8ROh08scxCes6MX04UjUHkbqN4tlO4yhDceElxoGIqCghm6hOdKcOPkakwsntVvx1ZyoU
	fm/mnw/xv
X-Received: by 2002:a05:622a:514d:b0:530:e335:4ef with SMTP id
 d75a77b69052e-53320076e0bmr26013661cf.2.1790611964291; Mon, 28 Sep 2026
 09:12:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ag8X7gcDw6jpJsLq@decadent.org.uk> <20260921175719.846883-1-irogers@google.com>
In-Reply-To: <20260921175719.846883-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 28 Sep 2026 09:12:32 -0700
X-Gm-Features: AclHuK-hxjh56xDGaVF6n08-980kUi7Pvlc_u2k27mAU3zemUfhouIkaRCBRU9o
Message-ID: <CAP-5=fWEvnp1S4N37U69Shc=S_C7Xn+NnSiTS8q4YxR5_EUsXA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] perf tools: Put Python egg info in output directory
To: benh@debian.org, acme@kernel.org, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org, 
	tglozar@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 10:57=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> From: Ben Hutchings <benh@debian.org>
>
> Installing the Python extension currently creates an egg-info
> directory in the source tree, preventing a fully out-of-tree build.
>
> Add the necessary runes to the setup.py comamnd line to relocate the
> egg-info directory in an out-of-tree build.
>
> Signed-off-by: Ben Hutchings <benh@debian.org>
> Reviewed-by: Ian Rogers <irogers@google.com>
> ---
> v2: Rebase

Ben's build clean up that I've then rebased and addressed an issue
with building in tools/perf seems like a nice to land thing. I'm not
sure what more I can do to push this forward, and I replied on the
list about the Sashiko feedback, which was a little wide of the mark.
Let me know what you think; perhaps the tags are not done properly.

Thanks,
Ian


> ---
>  tools/perf/Makefile.perf | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 2438b40eaaec..438102bcae6c 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -908,7 +908,9 @@ install-build-deps:
>         $(Q)$(SHELL) $(srctree)/tools/perf/scripts/install-build-deps.sh =
$(INSTALL_BUILD_DEPS_ARGS)
>
>  install-python_ext:
> -       $(PYTHON_WORD) util/setup.py $(python_setup_quiet) install --root=
=3D'/$(DESTDIR_SQ)'
> +       $(PYTHON_WORD) util/setup.py $(python_setup_quiet) \
> +               $(if $(OUTPUT),egg_info --egg-base $(OUTPUT)) \
> +               install --root=3D'/$(DESTDIR_SQ)'
>
>  # 'make install-doc' should call 'make -C Documentation install'
>  $(INSTALL_DOC_TARGETS):
> --
> 2.55.0.1082.g2b9226bbc0-goog
>
