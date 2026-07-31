Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261063A168C
	for <linux-trace-kernel@vger.kernel.org>; Fri, 31 Jul 2026 13:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785506345; cv=none; b=cXyfL4NR+f6LRZwQvn5GaA4admhdcw9lUcHYNP/4swc5bRyjev8TI4KVaWQ2b844vOW+ROnBrsVSNyu5RchC6n4DKgyIufWOWt9DTNhW0JcgGEL+Iy+f8xzwLwu1MvtGAbaXVS+9Y0QROV42vqeThwS9TC6MkDP9U2JaiKjatQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785506345; c=relaxed/simple;
	bh=EacsHN5gd694Om4cO+VdM45xgm7PfZ2qcTCqyzOnFX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HTc79oqCsohG6Oh8gdTGJy6IXJr9E50n8mT6/anbTsWo8B3BtewJZYnkdEFsCnQyjtx9iQwVB9xQyN8siLD2gv+RrUDY6QVGK2STMolLkFkQKKBCIaBQqHXaqxlwZUZAD1AURyKwN6ZGlFWwAUX0QZcHJRCeXnzs3AldSjz/MvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K12q32DS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K12q32DS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785506341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UHh618rO0vM6radRxFI6BssRv39RAWtnyom9bG/YUWI=;
	b=K12q32DS5EeuvB2XkZWXT9q+91nPKzUoFqQjmxIZGJkq3G6miwXDbvCCq/IXeYz71984oZ
	Ki3N0cO0239xdMefE+Y2o6TmxnW8A8kIKl139hHbhyEoabpmna3mCE/Z3Wid19lnpiwLZe
	4bcx48JHjdjaxqs+icdxTs98FogLy5M=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-KaQ92AOQO4OQc1eKxo5U_g-1; Fri, 31 Jul 2026 09:58:59 -0400
X-MC-Unique: KaQ92AOQO4OQc1eKxo5U_g-1
X-Mimecast-MFC-AGG-ID: KaQ92AOQO4OQc1eKxo5U_g_1785506338
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c15e555a164so83669366b.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 31 Jul 2026 06:58:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785506338; x=1786111138;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UHh618rO0vM6radRxFI6BssRv39RAWtnyom9bG/YUWI=;
        b=U2y0+ZmHdjlpXzX8phnzRwLtU0nRAPmq2bspd0Ypk2g7dwkamvoaVwrpCS6DuP/Fzb
         0bVuKPFSUGHuKjt4LQFUmiQio/Lm7PpgFGkdBo7doKsrlte80pgmpy66yCK0U/bXexCm
         J+lYvDS0g+2rV5ZlXxgrpTrYGQDrQKGLOmEfp/mOV88kxfx8GrItTQlHVDdXxD6BJh88
         SeAFmLWx/+4Sht+UY7jzaqKBX3hsuay3QtW/gLtAFo7yLl6XGMrOO5Q/ZbJWw+sMilKw
         b3kqkn737TBvwp3YK4ZTAdynM041Rv8C7yOj7RHKafUsjkUygVyzpTKjF/2X4by8dC8V
         UfVg==
X-Forwarded-Encrypted: i=1; AHgh+RoveuokkM2qRfSjGUOGO42KrXk6Qdfg3fnNJaNdeK4cgncgljzMpUMWeT2UmMHTZY64vI3zK7sZsj3kp3l7PPBRym0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2RBIwJ/P7ZzI9b+R1MoPie79Mr4OWXNd+rkxm9aAGPRQARy7q
	2UmxfyD+8E1sfl+Ilyy6A5nDYQJcFx37GR5UleU8BvyHteDrqtxFrxRhb4i9olRHq5rif2E0G5R
	iGum3w4ZjcH+5lZWnAETlA2iZHfXTRui82UAEL7Dg6/uuYjqVivXjjxpkL9gkrIFzGDxfOWoVvq
	qwaGRM3mtAGhVhobihpqL4Y2OBRm2zsWUqD4SND7dnbGc5u/jJ
X-Gm-Gg: AR+sD13CSsbpji0NhTa3pFOn/9SvEG94Ye7UFTBcjQIeJGMp9nC9zoDs+zhn06sA4YV
	mY1Nan9fs+RbdyM6VRp3gwlXOoL/kqZrsLeOK4/b07qVJxcvnCNZEHTEM5GzXrBaiitRUZ77sAd
	A6MiPJGbwK3pu84RxgkoZHcy3lDT2JUtsIegsYR9Kr6eWCqADYFx5EFD6e
X-Received: by 2002:a17:907:6d12:b0:c15:c323:36e5 with SMTP id a640c23a62f3a-c1fd3210e51mr137632866b.10.1785506338318;
        Fri, 31 Jul 2026 06:58:58 -0700 (PDT)
X-Received: by 2002:a17:907:6d12:b0:c15:c323:36e5 with SMTP id
 a640c23a62f3a-c1fd3210e51mr137630166b.10.1785506337840; Fri, 31 Jul 2026
 06:58:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722110116.1387495-1-tglozar@redhat.com>
In-Reply-To: <20260722110116.1387495-1-tglozar@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Fri, 31 Jul 2026 15:58:46 +0200
X-Gm-Features: AUfX_mz9s4eeokIMaLn1gkgjM3wqe8qBCF8VTK_X5sNxzUfZaYLOVdHCnx-bDWk
Message-ID: <CAP4=nvTtdtAU75Uj_N9mgmSLzA+LE2dES_29Ma_XVWytbOeyeA@mail.gmail.com>
Subject: Re: [GIT PULL] RTLA fixes for v7.2-rc5
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2B63ZV4Gu-w6lSxZNz6NzAVTTzAwkz_vvN7owMP9Cek_1785506338
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Steven,

st 22. 7. 2026 v 13:01 odes=C3=ADlatel Tomas Glozar <tglozar@redhat.com> na=
psal:
>
> Steven,
>
> One more RTLA fix, this time a one-liner fixing an older bug found just a=
fter
> the previous pull request.
>
> The following changes since commit 1590cf0329716306e948a8fc29f1d3ee87d398=
9f:
>
>   Linux 7.2-rc4 (2026-07-19 13:54:41 -0700)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/tglozar/linux.git tags/=
rtla-fixes-v7.2-rc5
>
> for you to fetch changes up to fafb66e5903c2bcfc7b7e259042a8282f18a6faa:
>
>   rtla/timerlat_top: Fix on-threshold actions firing on signal (2026-07-2=
1 15:42:08 +0200)
>
> ----------------------------------------------------------------
> RTLA fixes for v7.2-rc5
>
> - Fix timerlat top actions triggering on signal
>

Do you have any concerns about this fix, or did you just not get to it yet?


Tomas

