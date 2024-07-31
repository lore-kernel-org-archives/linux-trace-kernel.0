Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0B31A76C2;
	Wed, 31 Jul 2024 16:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722442695; cv=none; b=tdsrxNHo3CfoUeo4Wu70h4JYz1rcSBBHtENjfKp9Ze8S/ixP07cG7c97VVPF68UCV321YgTnf7d7Y+GZ/01SSbQ0Epag+fgf4/wUaRS1uOqPTUu1JxvFpHo3PHC30e3ADMTQG4F56D1jL85oJJid+QF34M4Z9mndBkv7ipbxUIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722442695; c=relaxed/simple;
	bh=ovFU0Zf+8cz15sgZhAPHqWvuYPbiiCZrvHyBq2enEdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bFSxpIHwrPzdTtakgLqTiaIQVy+uBTkrYFZibYKXlX5f4Ohu2Ejrz1nZezTrg7BlwFWHU/rvDYBM3LmpUi1offG8Xm5zw+DDwJqeTKkWr9XI1iCZHOG7zdc85poTHphvprDgfRQ4yMU0BaZD1kk6zcgxoN7EhvuJJiyzqesRNOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pnu9uk3k; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pnu9uk3k"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70d2b921cd1so5238987b3a.1;
        Wed, 31 Jul 2024 09:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722442693; x=1723047493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BgDDogKZ9F9yepFCVhK1mwghljJiMnC+ohG+x8Fh7OI=;
        b=Pnu9uk3kS1zteiIAITsusWSIRQp1R6ZlD70stwlwlwTFBvFxW3O7iyJ/o1we6HkfQ5
         zYsZjpKpB4F1phR9w7PBNmYjCpYJ1wWSMpG3L/z2hYlohrYX12PxZCqk9iVCKZHQCAgX
         4oh+iwm9Sho1lDlD2VIYeeQGuHKfZo7jpQSAOgBY+HqBJFh3krULKtdY/uDtZ3sMaiW5
         R76RIYLELJAd9XRgG6bzLDjx2018KIjd1XJf/1nDnHUa3jyQGmwrzOckZ9P9yIAzhTi9
         2IZvtu9rKVCvHkQd8ORAOStcT1kQ0TymyueMtb7JJ1KqqbkrVmojK6ouLvxM4SBdWRju
         h6sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722442693; x=1723047493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BgDDogKZ9F9yepFCVhK1mwghljJiMnC+ohG+x8Fh7OI=;
        b=NaJMjcGXWHFtoq2fgOHUIDEXH1Ccoat3IGXqFVsMa/6m6oWCRB/u1sf7Va8uD5Va0f
         yUFIFoefs1MXCgOjpCt57abHiewmNsK2wVnf/pLEsnppP+DSK3zKRgsfnBRrwawbNmUM
         VR2kQ8DMF9pLQDCZ69mwg6LeaGxJnfwd8dWvJDNnfqP5R6eIrKhLYkbtwDskRhE6GOWD
         xeuOVUTIELLTLWspnsq5HXWxiRmqND9x0H73j7GJFkkGkuV7iA61H2uIXD++MlAlAc2z
         MsSiM3fSFvzxXbb4FZJOlIryaLGIJTIzjOjNqkDXU1dWjp+w5n5HRUMPdlyYkDml9+V7
         Ix+w==
X-Forwarded-Encrypted: i=1; AJvYcCUY3M2mTfZpI9XqsT5icDtbdhyJlfgGaiDHOVWohEXr29riV7b+1NlRG2LaJMBIPmAc6yKzkPTTlGCsQpl1SFKQNwDqqNvjPsNd8KEqymJc4QkvnQaRZnR7U2bh4p9G7y4WTDKgvstqp+GZM4MjPcQT
X-Gm-Message-State: AOJu0YykhyPHkm3GqRWezL0txr9xidqH2HTt3GfwuKSIlBC9f95iGFtO
	tGu2r/kbsLCvrNHO4jzgdAotfvZtlUeJKgVhPc+JUVp8HULHh+SG/THRmz3HbyrAhQMg6SCul2J
	NbP2cgTcK7RKs4P6FuPd0UaWs9cI=
X-Google-Smtp-Source: AGHT+IGW4q5z7MPymSwiMszjOGrKLeLp213GRDveS53IgwTywyLG1F1GinxVCAtC0nyQEKaeOyUAGPic0q5yJkL7YMI=
X-Received: by 2002:a17:90a:cc3:b0:2cd:619:6826 with SMTP id
 98e67ed59e1d1-2cf7e60bee6mr17336756a91.34.1722442692615; Wed, 31 Jul 2024
 09:18:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729134444.GA12293@redhat.com> <20240729134535.GA12332@redhat.com>
In-Reply-To: <20240729134535.GA12332@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 31 Jul 2024 09:18:00 -0700
Message-ID: <CAEf4Bza1_njsVUad8so9EFxy8VmJsTfzaaAahBYFtOqdF1HAjA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] uprobes: make uprobe_register() return struct
 uprobe *
To: Oleg Nesterov <oleg@redhat.com>
Cc: andrii@kernel.org, mhiramat@kernel.org, peterz@infradead.org, 
	jolsa@kernel.org, rostedt@goodmis.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 6:45=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> This way uprobe_unregister() and uprobe_apply() can use "struct uprobe *"
> rather than inode + offset. This simplifies the code and allows to avoid
> the unnecessary find_uprobe() + put_uprobe() in these functions.
>
> TODO: uprobe_unregister() still needs get_uprobe/put_uprobe to ensure tha=
t
> this uprobe can't be freed before up_write(&uprobe->register_rwsem).
>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/linux/uprobes.h     | 15 +++++-----
>  kernel/events/uprobes.c     | 56 +++++++++++++++----------------------
>  kernel/trace/bpf_trace.c    | 25 ++++++++---------
>  kernel/trace/trace_uprobe.c | 26 ++++++++---------
>  4 files changed, 55 insertions(+), 67 deletions(-)
>

You'll need something like below to not break our bpf_testmod. And
please send pull patch sets, not individually updated patches, it's a
PITA to deal with. Thanks!

commit 9f739a9997ab833394196459fa7e6dd4d13dd48b (HEAD -> uprobes-oleg-clean=
ups)
Author: Andrii Nakryiko <andrii@kernel.org>
Date:   Wed Jul 31 09:15:46 2024 -0700

    uprobes: fix bpf_testmod after uprobe_register/uprobe_unregister API ch=
ange

    Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 5f152afdec2f..73a6b041bcce 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -431,6 +431,7 @@ uprobe_ret_handler(struct uprobe_consumer *self,
unsigned long func,
 }

 struct testmod_uprobe {
+       struct uprobe *uprobe;
        struct path path;
        loff_t offset;
        struct uprobe_consumer consumer;
@@ -458,12 +459,14 @@ static int testmod_register_uprobe(loff_t offset)
        if (err)
                goto out;

-       err =3D uprobe_register(d_real_inode(uprobe.path.dentry),
-                             offset, 0, &uprobe.consumer);
-       if (err)
+       uprobe.uprobe =3D uprobe_register(d_real_inode(uprobe.path.dentry),
+                                       offset, 0, &uprobe.consumer);
+       if (IS_ERR(uprobe.uprobe)) {
                path_put(&uprobe.path);
-       else
+               uprobe.uprobe =3D NULL;
+       } else {
                uprobe.offset =3D offset;
+       }

 out:
        mutex_unlock(&testmod_uprobe_mutex);
@@ -474,10 +477,10 @@ static void testmod_unregister_uprobe(void)
 {
        mutex_lock(&testmod_uprobe_mutex);

-       if (uprobe.offset) {
-               uprobe_unregister(d_real_inode(uprobe.path.dentry),
-                                 uprobe.offset, &uprobe.consumer);
+       if (uprobe.uprobe) {
+               uprobe_unregister(uprobe.uprobe, &uprobe.consumer);
                uprobe.offset =3D 0;
+               uprobe.uprobe =3D NULL;
        }

        mutex_unlock(&testmod_uprobe_mutex);


[...]
