Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2788D3DD506
	for <linux-trace-kernel@vger.kernel.org>; Thu, 21 May 2026 17:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779385857; cv=pass; b=WmTw1lXsqgvMeFq8gMexGWrYbw0d5jdIySm3NqaFl7oB1BEWF5cluCzzxvN8HT5OjDaF6c/AUzRmB/uzd3+0odgxp5kz3yNgxKk3UEQ4oDpM/ANzLb1e2Wgkll8X9b83BVyjqeGysdLLbYEY7SXUMUOZSMLO22pXYQjmPckVgJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779385857; c=relaxed/simple;
	bh=uZEmKQEPtBiulFq5qAYPUwHEbakFqp23BZT72IvQHOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hfXa9n7xsj4Ck0DPGcGv5bKeB+s4YusvU5faIrvUKNelJLoHqOWh8W5RW3T+OhoojdrbyOc0YU4OsrBaBZaAN0yegMyvpq8q+r8bZgt+Le7MMcYoDciWVMHIGvh6Rp+2AqjA7pZsFXchUmBhjDUTPTWpkS9o2MQx5X1qoQNtymo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vSY1taG8; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vSY1taG8"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ba180a022dso55ad.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 21 May 2026 10:50:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779385855; cv=none;
        d=google.com; s=arc-20240605;
        b=IZsvDh+DUSwvjk7L26E9RtF34T2UMevnsTHpKYBqLgMqGtjROMxYfuuEGgGexzFurZ
         IVn1p1zBTwqq31iQ9ChKOr3WcVuHsE6+LDOqgsIF3Ex5kiNn2/gh9ak6HEB72zhpfGM3
         u7jhLcNXiSar0CC/KAtDYTGkRNSCl8+Mc3z10GHG1kMyh7fMar954UqM6WjSW26wqcCc
         1B1KDvGWdDvf59fagJZMZqhe508kjFMluYZaY/P6Po4LRLIaB6HXQwC2DvyGHOMpXOn9
         NJJj4MtLTJIrPeIHicKf4J9WoCfcaUj0I/5OyrFyiEl9o2bueek4w0aOkAkTW39LP6WA
         s2RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=207OftV959LjRYpr372rL5wikkcj8n/uFnR1W8tNHp0=;
        fh=6Pwr4U2k16Teln41vrEHziByNZoJcSzU8bXRDROxtt8=;
        b=X3EFn7HDXYbU94hHcwgS4y1mbPve8QUNEnn4xcreWuyZKqF7JjzXEIP4YUoS8ThY1L
         5g7virwPHL/aYxr4y7t4EHOPDWLl9UnwXPpkz1hA6RMe1WuLc3NKNY3eGkz7T4jlSfgm
         TW7ngohBehTpLIzkCVjkIQRIkMgU0EkeJt7URp+I5IkRCxAiOqdzS+WTmRQ23hikIlKQ
         0JXezvD5ac7AM93YPaKreuGl7IU9QZ//KnAUrc0zTVAJ5gSFBVZBVE6C8K9x5n7g4tIt
         PH/3+vu+DWVUklTPMtGzyN7W5frBx7IeASzMpSGmaeD2p9mSSvztSE255/jZ6LnEiZYx
         Ppgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779385855; x=1779990655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=207OftV959LjRYpr372rL5wikkcj8n/uFnR1W8tNHp0=;
        b=vSY1taG8NmlecMxw38pWBHjQtdp+VRB16/lAo60EEH1RcO7tD4gSRIvndEEMFEcFvK
         tBb45tHxiLKJ6ZA0bD0SASyLlgbJS/BLSrlRRXNO6ZkGc2KgfGgfGaFRCXexZQyf8oKV
         01gyCJi1OvBNrWWbxqui1xf4Wl5Mp627VOPBW++zvc8FU65ZwIYaaKx6AtZxiPxupwON
         0nruh1FtdYWZDiSnjpgU0FDnkiUHL/a91QWlAo3OfV9NPe9U758Qhx+6pQ5zt5cm3Z0q
         kHO9K/9RFGp/XNnO5lK6DND+dx+HtX9aiSrcTL4RJWZS03H5vYrUJi+2FDH8HifrhieX
         l82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779385855; x=1779990655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=207OftV959LjRYpr372rL5wikkcj8n/uFnR1W8tNHp0=;
        b=cC6B0QxjS14EK/yYoW/XlaGDd1QQFTxHLdjs8iUY+ZF8x85Ioj7HDf5QmS8TMtE5bf
         o96S3uM1kX+lvO0+49SE9wr3Q0Tw/aFjb5cOpTmud6xdettWlHgH25SAS3tK52EiXoOj
         IlFH/iECpciWeY4zBne5D/ybFH4kSwR+WaVfkeuLDADmGJUVCa2hY+u8Pazj26ElhMP4
         m0V33OMVsEWgxiHUYsj9DOji8EH6cTqZlTw4eLM4Tkqp29VzghfzLUqKycsrEAAA/kMn
         8QlOtbfu1KC7TOnoW3+rgZTXrpbNOpAOH23BPpN4E/YukVyP4H/HHpPZuN80EpFVOBLd
         XuvQ==
X-Forwarded-Encrypted: i=1; AFNElJ9sHOD+FjIH5OHloRK+lGVof91Wog8aGkwcftm/pP0bmozSrO0bR4E64LWDG88b740ku9KlHhBoeRmqD1H1BQ94LxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRzGOB5U14uzPmCUS+5MOenwczs92cduAhZtE7513AtHBxjlkh
	3Bvk+NikQzgDVRNWxtDH94o9SaHAC6e/aDR2OKaGmYpU9RSsCxYLbw0A/UYpuvZFmWCJmNqhE64
	E6YA6wUjKl0nlr4mylMdmC60uxNpTdAFzxeafopFi
X-Gm-Gg: Acq92OGee4gWjm/YTPT9PspSIrn7aDSp5msk8BUh+8rOkb5p+92Mao0KWh0U4CxDzGP
	YT4/hapoyOROiH430OpgsgeuXaJytS/D9hNzi1ZQ2HiZrT+jtKSi+M//l8l5J2LH+T5SpOrrrS1
	J09XleZhY6e1BAhiDcnRDwzErF9KutUFnrZzPyH7rd1+4WyurN7vHlwhD9Pqr1mt81FNueEOmCh
	hmDbvK2iZ2XQz7BPKXH/TlWnZlGFPX/FgwvJNKLUfRU9oWTnSGMmFo0SO1sDk7yV2E9a/SjWcXX
	yVYcWSKb/tVE8LBQjXdo6A0FnY4J/11iqlFyBMOqU4QwD5do
X-Received: by 2002:a17:902:f78f:b0:2bd:6dad:7ccc with SMTP id
 d9443c01a7336-2bea22258d8mr2812855ad.24.1779385855086; Thu, 21 May 2026
 10:50:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ag8X7gcDw6jpJsLq@decadent.org.uk>
In-Reply-To: <ag8X7gcDw6jpJsLq@decadent.org.uk>
From: Ian Rogers <irogers@google.com>
Date: Thu, 21 May 2026 10:50:42 -0700
X-Gm-Features: AVHnY4KHqHkaTccso9Ae1JwavhgkDWK8Q23HikysKTcCQJ7I9OB_ihLrUTe10XE
Message-ID: <CAP-5=fUy-hwmD2WXpmzJAE4k3U4WNYEezy3Dh1cVSFw_LPGJzw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Fix out-of-tree build of some tools
To: Ben Hutchings <benh@debian.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, 
	linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 7:57=E2=80=AFAM Ben Hutchings <benh@debian.org> wro=
te:
>
> perf and rtla currently don't fully support out-of-tree builds, as
> they may still create files in their source directory.  This series
> fixes all the instances of this problem that I have found.
>
> Ben.

Thanks for the cleanup! I ran Sashiko locally and it noted that we
should also fix the clean steps to remove these files (I'll copy the
full text below).
Reviewed-by: Ian Rogers <irogers@google.com>

```
commit cf212be834ce6b0df5cccdbc4ad977a917ff8e48
   Author: Ben Hutchings <benh@debian.org>

   perf tools: Put Python egg info in output directory

   Installing the Python extension currently creates an egg-info
   directory in the source tree, preventing a fully out-of-tree build.

   Add the necessary runes to the setup.py comamnd line to relocate the
   egg-info directory in an out-of-tree build.

   > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
   > index fc92d6ceac5b..b9a9bdddb89a 100644
   > --- a/tools/perf/Makefile.perf
   > +++ b/tools/perf/Makefile.perf
   > @@ -905,7 +910,9 @@ install-bin: install-tools install-tests
   >  install: install-bin try-install-man
   >
   >  install-python_ext:
   > -       $(PYTHON_WORD) util/setup.py --quiet install
--root=3D'/$(DESTDIR_SQ)'
   > +       $(PYTHON_WORD) util/setup.py --quiet \
   > +               $(if $(OUTPUT),egg_info --egg-base $(OUTPUT)) \
   > +               install --root=3D'/$(DESTDIR_SQ)'

   This relocates the egg-info directory to the output directory, which
   helps keep the source tree clean. However, does the `python-clean`
   target need to be updated to clean up this directory?

   Currently, `python-clean` is defined as:

   python-clean :=3D $(call QUIET_CLEAN, python) $(RM) -r
$(PYTHON_EXTBUILD) $(OUTPUT)python/perf*.so

   Should we also clean `$(OUTPUT)/perf.egg-info` (or `perf.egg-info` for
   in-tree builds) to ensure `make clean` removes all generated python
   metadata? For example:

   python-clean :=3D $(call QUIET_CLEAN, python) \
                   $(RM) -r $(PYTHON_EXTBUILD) $(OUTPUT)python/perf*.so \
                   $(OUTPUT)perf.egg-info perf.egg-info

   commit dd754ea75966ec7ade41500afeb32d944f20a8f9
   Author: Ben Hutchings <benh@debian.org>

   perf tools: Put Python bytecode in output directory

   The PMU events are processed into C sources by Python scripts,
which
   normally results in writing bytecode for each module into the
source
   tree.  This prevents a fully out-of-tree build.

   To fix this, set $PYTHONPYCACHEPREFIX to relocate the bytecode cache
   directory in an out-of-tree build.

   > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
   > index fc92d6ceac5b..b9a9bdddb89a 100644
   > --- a/tools/perf/Makefile.perf
   > +++ b/tools/perf/Makefile.perf
   > @@ -400,6 +400,11 @@ PYTHON_EXTBUILD_LIB :=3D
$(PYTHON_EXTBUILD)lib/
   >  PYTHON_EXTBUILD_TMP :=3D $(PYTHON_EXTBUILD)tmp/
   >  export PYTHON_EXTBUILD_LIB PYTHON_EXTBUILD_TMP
   >
   > +# Put Python bytecode in output directory
   > +ifdef OUTPUT
   > +export PYTHONPYCACHEPREFIX :=3D $(OUTPUT)/__pycache__
   > +endif
   > +
   >  python-clean :=3D $(call QUIET_CLEAN, python) $(RM) -r
$(PYTHON_EXTBUILD) $(OUTPUT)python/perf*.so

   Similar to the egg-info relocation, does `python-clean` need to
clean up
   the relocated `__pycache__` directory under `$(OUTPUT)`?

   If `PYTHONPYCACHEPREFIX` is exported to `$(OUTPUT)/__pycache__`, running
   `make clean` currently leaves this directory behind. Should we add it to
   the `RM` list in `python-clean`? For example:

   python-clean :=3D $(call QUIET_CLEAN, python) \
                   $(RM) -r $(PYTHON_EXTBUILD)
$(OUTPUT)python/perf*.so \
                   $(if $(OUTPUT),$(OUTPUT)/__pycache__)
```

Thanks,
Ian

> Ben Hutchings (3):
>   rtla: Fix output files in source tree
>   perf tools: Put Python egg info in output directory
>   perf tools: Put Python bytecode in output directory
>
>  tools/perf/Makefile.perf            |  9 ++++++++-
>  tools/tracing/rtla/Makefile         | 31 ++++++++++++++++++-----------
>  tools/tracing/rtla/tests/timerlat.t |  4 ++--
>  3 files changed, 29 insertions(+), 15 deletions(-)
>
