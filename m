Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8902F25F3
	for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Aug 2026 07:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786432993; cv=none; b=RV987s7GIreNSy0amZiNLBEAPUJ+pCq3CSIYlLFW7n15985EfkJIVCXVieTdOMk4UycBZBArh9hFcs4FIK2ejbVhfKMITHbwaOwAmC9NqxonmJGz+PZnDoKmWgm1HqzyWNpdEeQpCNJVkY9PSdMcqHMuXe4psJtcYPEWdZyP8Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786432993; c=relaxed/simple;
	bh=X0hdybD28tQSSUJcKWyRQqNC8MMk7mUyibywTJcZkPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nKMmx3rL7L3d+9P4pQDiXATwPZOfBgUysgQO3vFh0YrOzV8ZtW8A+mxriEZp5dTna5D81sGh7x3HeCduq0ojS1XAe0Uq9WHQpOqZAVaG8ITdwlajqyBw8KpbP0Bt6ZboeZG4riNvn6yhJsQlsRwh5SCFCMc+6iOjySZkUgJJuS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ewnzJboG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ewnzJboG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786432990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X0hdybD28tQSSUJcKWyRQqNC8MMk7mUyibywTJcZkPk=;
	b=ewnzJboG0Cgdi3G+lvlYIPg5SaRCxKA2BkbPlaydREDT5Oz/qcNO/sIzO25N91p2jw8Msj
	K4q9WPbxkkeU5qU9tV1QjVVe7g29YKL7E54O9E/zP0xChBcJhTinIdSydkD4YxxkluyupD
	wkFXHhKj0NYIYgoApSRyZrnTsHBKjM4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-6Uv-C0sKOuSDiy5Mn0GHcQ-1; Tue, 11 Aug 2026 03:23:08 -0400
X-MC-Unique: 6Uv-C0sKOuSDiy5Mn0GHcQ-1
X-Mimecast-MFC-AGG-ID: 6Uv-C0sKOuSDiy5Mn0GHcQ_1786432987
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c16740eb587so198501066b.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Aug 2026 00:23:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786432987; x=1787037787;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X0hdybD28tQSSUJcKWyRQqNC8MMk7mUyibywTJcZkPk=;
        b=KQcUP8xdWe9TmbtS8qATrnAoR34Hoo/vxdeWpwLM+l53haV9RF1s48gzp6uIUG9qHL
         uJz032KJob016xlz2isvFDKIJppLLzyr5PwZzqZMTJTeXUUy+g/BtnpWy3EoX+sWHg3a
         ICZ/zt17bWC/SdsHSPQHzSoJ42dw6RZJKiXskEnBY7tzbMnOKdm49s0o8UdB8rWX+nN4
         ibxSng+ZOQ9D9EKhqerRKwxwb1+uddKk52uHZtZgOlolhhePz0Ubwk+B1Y8KY9haEjml
         41M/x/hff5RifSok1ES9hbtYImIScQggqbxW7LDbIKJTJt1Mn4jlHOnD54FIOhknSRTn
         wjQg==
X-Forwarded-Encrypted: i=1; AHgh+Ro0mqE+nuppcLeeqI8LX++UomvjDH9eov5pkcfkv55ifiQDtHU+2SmcFPKvD6gVVfm+3YUnplR00zcH/b6dPVZsSNs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1GVn8SptTHtM7h7jwQ3dnHmmKU4iUSxh0vWb284TtVRmMzSUR
	SNPrHQADR1fmAkOxxmKEHRtgLMu4pw1CdnKWIgaeVQDumgBq1aeGFmnBsaF/XGL3bOM/MtG82F5
	V+0iocJvs5fgMveq5UA/8ssrc3uXUV4lCA1KlP3qKEb/3fxyK+yuNP0LZZ4a/FxzTEcuL2tVTtt
	xByPvqe0FVVU0UdqJUiySH7Rk+0p1mZW/D/vFXpIpZ2uaQ+M82
X-Gm-Gg: AR+sD11GooFlxDcVLbYcmPazGilfkXzdAoabXlYFy/FF8tB2UKV3tozzROxJJ2DPrhf
	eeL987lakVHhO5wnSifT6d6bVgdts4UkUnD6VSc/DyCY32rpwFi+E85MkCXLsLr5kTWUFyjQDl7
	MoFkRQb67vum+N+N45JTp46/1Tq0rmyTUpj69POWgVMPuHe0jgCC6n+NBr
X-Received: by 2002:a17:906:f583:b0:c20:3733:a8c5 with SMTP id a640c23a62f3a-c20e608810cmr49288766b.8.1786432986699;
        Tue, 11 Aug 2026 00:23:06 -0700 (PDT)
X-Received: by 2002:a17:906:f583:b0:c20:3733:a8c5 with SMTP id
 a640c23a62f3a-c20e608810cmr49285166b.8.1786432986202; Tue, 11 Aug 2026
 00:23:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805151055.870722-1-tglozar@redhat.com> <20260810210425.61435b0b@robin>
In-Reply-To: <20260810210425.61435b0b@robin>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 11 Aug 2026 09:22:54 +0200
X-Gm-Features: AUfX_mxkCbUyM3vF9Bo0LlQkJRP2J6BcmIhDswN_3MCz8HI9t5r3QXSmVqyUgbQ
Message-ID: <CAP4=nvRWKYdkfr-9_1OMupZfF0nUYVVtMd7Vwsd3o4pO__SCew@mail.gmail.com>
Subject: Re: [GIT PULL] RTLA changes for 7.3
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kNHxf0WOjmhoBn1qwEwdUuB_fWslej9q6M7QxX5OPHc_1786432987
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 11. 8. 2026 v 3:04 odes=C3=ADlatel Steven Rostedt <rostedt@goodmis.=
org> napsal:
>
> I just tested this on my VM and have the following results from "make che=
ck":
>
> [...]
> not ok 20 - top verify -c/--cpus
> # Output match failed: "^Affinity of threads: 0$"
> # Affinity of threads:
> [...]
> not ok 21 - hist verify -c/--cpus
> # Output match failed: "^Affinity of threads: 0$"
> # Affinity of threads:
> [...]
> not ok 26 - top verify -u/--user-threads
> # Output match failed: "0 kernel threads, 1 user threads"
> # 0 kernel threads, 0 user threads
> [...]
> not ok 27 - hist verify -u/--user-threads
> # Output match failed: "0 kernel threads, 1 user threads"
> # 0 kernel threads, 0 user threads
> [..]
>
> -- Steve
>

tools/tracing/rtla/tests/scripts/lib/get_workload_pids.sh is for some
reason not finding the user threads (as the tests for -H and -k
succeeded) on your system. The threads themselves had to be running,
as timerlat is reporting samples from them. The script and the related
tests cases were added in 7.2 already, this pull request does not
touch them so it's most likely a pre-existing issue.

Either way, I will look into that, thank you for testing. It might be
environment-dependent, as the test relies on the test script (executed
as an --on-threshold action) being a direct child of the main rtla
process - which only holds when the system() shell executes the script
directly, not as a subprocess.

Tomas

