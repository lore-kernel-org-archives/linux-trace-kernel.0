Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF654E4323
	for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Sep 2026 18:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790014360; cv=pass; b=FGsOf3Ofb6jeOaZco81QPpza2DZwY5a3CIdscQG5coZY43ceRjnphkFHtbwYZged+naanKFyuXR8v8mga1agbtrRgibKA8VMRRv51O3RJACfVznTEtnVE5R0A22bNFIuAxMR4HBOpghl8vMH5pi4546BiKeQ4hB7UI2xP+CT4Ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790014360; c=relaxed/simple;
	bh=pxCditSPn667R8GM21+T7lWhaHVejNe/8zp9gD2W2Ic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WrTvWzKUrP84RVPW35sNtWegiTSERM/tUIsK/qsMeMIKxMOInyrnpTDNESvY8b3cYowOwkfm2VYV4BPlBoIhQPREfNqDK7A+GBXaThsSokaZSeNbtqoYDUPKYC7mMMFITpsYT6qBYOZ+SlA4PRPxiIC1z/6XgQ7ImxDxzb3RZDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CQjsiIcQ; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CQjsiIcQ"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2db33db4de9so31805ad.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Sep 2026 11:12:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790014358; cv=none;
        d=google.com; s=arc-20260327;
        b=T/Ge4cCgkYITKcIcBJbnRYJ0JfNmZNYoVVcpeKlOqzpLVd0fT/YqFMUkM5HnavbTVp
         77VvqKcEeRQSvFJ+7yoIMl560BkKCRh6sSnnOub6lUMqZiM1zIWxVwI5GU3cfiukUm6x
         Av6p8R/jvRPNPm2aesxKMRX6qoL1Ew89hArU/+dhC3nw9paJ/BaKe5UVXE3+tVoyXKYZ
         lymz+2bCyLOfogxyqr5Gc5hav0p3AcTzx2s/6lT/n5d06JZ4CKlq/bZS5YrpWNcILNqx
         aqNStkZWgUYepgKbIz97cUe7o6hWGvEfw9gDheKWUoqSPX1hThlFUyd9Jiy61AGjBxM+
         Z4Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QHAP+ThF7TxWgEqj8k74itg4E2H+sNPwvnziw5xjhM4=;
        fh=+oxVP2Ivsq2du6sYxpdGsW2MAdlyHA5e80XdkH83cmQ=;
        b=IMTuWT6bDPRmEBUYTQvgK+fO+iS4mhmibBAEbQFAEcbSgm0KgrGZUIcrb3TIqHlIGG
         eohWyyH3wFnDvICgiC3C/HuMfHwlikHlCqDeYLvi13V+8P3zBaw/QI4cK1wOtQT9TX//
         i6cchap41NRWknCqVopMqWFF9oeYSgGqUxlxGGWIQs+R4Usy7sSQNVjG1QbTydKnGk+Z
         vawcSMJxiONzFOTMoWouuvjG4ktjaYYheF1KKfS0npt2uW53YR6s1f9FP8cr93fD5hsu
         xW/GhaFtYMQSld54GglnQzZ4joQPBS2GUoNvEe7/wnGupEjWT/mrMvN71BleVRNLVyjj
         Sx5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790014358; x=1790619158; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QHAP+ThF7TxWgEqj8k74itg4E2H+sNPwvnziw5xjhM4=;
        b=CQjsiIcQqKorgn4BH/vP6SXfG5ScUCq9iNmLYYoPhL8z0vWYArmIbJ96opXVlSbKeW
         aZl6k/GsQp8jcZ+zkfPQyc6U2bRgvUQqNHYFLy51V6DdypkXgKja6abZdOJTY2J8NYAv
         hhFXOgFa81VdgE8oYQRSraXmYKOkwizoQQvfSbQGREkPLVOlqziLI0Ni5EjD066kWKZ1
         adDh4DwhP1Np/WCIp1lI5AlOrj/FlIouB6vnbmaGc3ntgzm6oBcGfjfNEN2yPgjfzfjl
         sFqIni+8TYecqTyT5eq8sX8Mc7MxkCefYKZBH6xCichpYb+ZXb0SCkKjmztDzcvP8CZW
         VYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790014358; x=1790619158;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QHAP+ThF7TxWgEqj8k74itg4E2H+sNPwvnziw5xjhM4=;
        b=U1R++SNLnJSFGP6BHi0Vp/Xq+N7KWTW7COIwWfQF4jXrj+BAlbNX0ChYA71rT9naux
         dbRwRxBzQ8BgjQJ7KWlvr+B++JjtyOZuCC/ZuZIB46PM2Fg0ZReXMIFJSUi2DFoidd45
         5cwJoxkYKPmeQ0aQ78qL0NUFjmNg6JCr8Ny8MTsxvBkmHPr2IctLS2jK/1KlF6lK0ZHC
         QOAiNrsmR6TqXqikgbMzJsjzyx172o9/QT+o++4w//BOerHTW+rnksCNzlcMI/3hv36U
         kZ20lri9EghrGu0cV0XicmkqebksdmdGCd3/dyjt/BjWbMVGowqlGq0l96srfF43YKEk
         X1Lg==
X-Forwarded-Encrypted: i=1; AKwUvBx8vlTWNo4DZvoFdv66Ey6qCkuWa4M9lP0uj3Ek7vqyJUS8DAo7w+Mgyo6aESmBhy09yActPG09JR2hsyY2bBI8Jks=@vger.kernel.org
X-Gm-Message-State: AFuF++mNXLuMzLC8jrJtzrm48KFrlxumDyCYAq+gFbQLpNEP+sTaHWQk
	CC6e/0qJCUz3gPmiXvw3Ktj0WYz/fXHorWpqCkB5xk2x1nxirS5FvQfDR4TcxA57CvYXRI4CDjP
	X9sTtBpIFpIOv80jXE3H/Oye6rgFhSfXcKnIJ/TqN
X-Gm-Gg: AYBFou0cOhzHqfQd94ltoPaHPMizayKa+fAZflQhiCrPCV8OfTVE+s78jsClBHHYicY
	/qurSkBVJVz+A7sOoYQE8Z1Fbw6RegVmLfXBKB6+aujk7+0Ce9VPFo/nxpwaXJxtZ3hDAyPokeK
	1AX7qnMDQ66Dj5f8YzI2P2frWOceExgLMFa5RIixY4AdDvSjJzjElk5yLZSmdmZhDRvXuh3dw18
	m3Gt+cAh50ympwYUC0st2osPl7XLvbX3BC5vXRiiHTWBdkuMXw43maRfqY10JyQEuTdYk9L4u5r
	2e/dxuCNgjMBeRhVkO9oOEdW4ee1nHcR+RBnT6/J5fFmSIa4qB7n0intf+5vyzsf5LFFhHkcSTq
	CTozlILKV
X-Received: by 2002:a17:902:ce12:b0:2cf:4353:f117 with SMTP id
 d9443c01a7336-2df5aae1b6dmr518255ad.0.1790014357595; Mon, 21 Sep 2026
 11:12:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ag8X7gcDw6jpJsLq@decadent.org.uk> <20260921175719.846883-1-irogers@google.com>
 <20260921175719.846883-2-irogers@google.com> <20260921180544.064DB1F00893@smtp.kernel.org>
In-Reply-To: <20260921180544.064DB1F00893@smtp.kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 21 Sep 2026 11:12:25 -0700
X-Gm-Features: AcwNN1WtQRPw4NjyM-aaF9lzmK2cNFGQrwApgnAZh98Wf0nWalcexW5EAz7_hpk
Message-ID: <CAP-5=fVQui77+75dHLMgddUM2P3GhZqV2wbdVUkcG_6jwWqECQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] perf tools: Put Python bytecode in output directory
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 11:05=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] perf: root filesystem pollution or build failure due to stray =
slash in PYTHONPYCACHEPREFIX
> --
>
> commit 3de8bc01d44a9b11e10c327ec26bbff8605926df
> Author: Ben Hutchings <benh@debian.org>
>
> perf tools: Put Python bytecode in output directory
>
> This commit sets the PYTHONPYCACHEPREFIX environment variable to relocate
> the Python bytecode cache directory to the output directory during out-of=
-tree
> builds. It also updates the python-clean rule to remove the new cache dir=
ectory
> and perf.pyi.
>
> > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > index a0b23d20d005c..50bde95c78a54 100644
> > --- a/tools/perf/Makefile.perf
> > +++ b/tools/perf/Makefile.perf
> > @@ -397,7 +397,8 @@ PYTHON_EXTBUILD_LIB :=3D $(PYTHON_EXTBUILD)lib/
> >  PYTHON_EXTBUILD_TMP :=3D $(PYTHON_EXTBUILD)tmp/
> >  export PYTHON_EXTBUILD_LIB PYTHON_EXTBUILD_TMP
> >
> > -python-clean :=3D $(call QUIET_CLEAN, python) $(RM) -r $(PYTHON_EXTBUI=
LD) $(OUTPUT)python/perf*.so
> > +# Put Python bytecode in output directory
> > +export PYTHONPYCACHEPREFIX :=3D $(OUTPUT)/__pycache__
>
> [Severity: Medium]
> For in-tree builds where $(OUTPUT) is empty, does the unconditional inclu=
sion
> of the slash cause this to evaluate to the absolute path /__pycache__?
>
> When Python 3.8+ runs during the build, it appears it would attempt to wr=
ite
> bytecode files to the root of the filesystem. Could this cause a regressi=
on
> by breaking the build with permission errors for unprivileged users, or
> silently pollute the root filesystem if executed as root?

This is already the behavior. The difference now is that instead of
multiple __pycache__ directories for the directory the python script
is within, there is a single top-level __pycache__ directory that is
handled by the clean step.

> [ ... ]
>
> > @@ -919,7 +920,12 @@ $(INSTALL_DOC_TARGETS):
> >  ### Cleaning rules
> >
> >  python-clean:
> > -     $(python-clean)
> > +     $(call QUIET_CLEAN, python) $(RM) -r $(PYTHON_EXTBUILD) $(OUTPUT)=
__pycache__ \
>
> [Severity: Medium]
> Since $(OUTPUT)__pycache__ would evaluate to __pycache__ in the current
> directory during in-tree builds, would this fail to clean the incorrectly
> placed bytecode directory at the root of the filesystem?

Same issue; yes, the build would fail but the build would already be
failing if this were a problem.

Thanks,
Ian

> > +             $(OUTPUT)python/perf*.so
> > +     @if [ "$(abspath python/perf.pyi)" !=3D "$(abspath $(OUTPUT)pytho=
n/perf.pyi)" ]; \
> > +     then \
> > +             $(RM) $(OUTPUT)python/perf.pyi; \
> > +     fi
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921175719.84=
6883-1-irogers@google.com?part=3D2
