Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE8F302750
	for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Dec 2025 08:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766390497; cv=none; b=RxDYYySdAAlnY9b/+PcEPEi7zGzzYVwnA19MDfZi2N5MkwQx/VpPws1nF+UgU1khQIC2m3eCkc7EULGZpjfqnaPHjgGH/y6GJ1knRh50t10L4DgrBzN7nvUo4hM5DpEWGDx/UQwdPu+JhEBYFxNFKeFcoc5IVSPnoIrMza4Sb+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766390497; c=relaxed/simple;
	bh=U0b6/RRZoU9PJ37clj0ubioxb/HZFHSbQmsQdaqPnwU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sfVWh6W7j3SwitBmZkTACozH8anYj2CKVejXvcPx7P10M37ouBLy1QhIcoLtl/6/v3hC0kKtukhQjRal2zIG+sFClJ6MMn9T/SH7d4NB3PbA5XKLKmCxHtXLBT8nmhfT9Eu6Q4/V4JVoyDlflrbU2ILgCpB2VOaODEMVeaRQihA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZ2yaeAi; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZ2yaeAi"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a0bae9aca3so52515925ad.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Dec 2025 00:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766390496; x=1766995296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v8zLCGtUEy59h/vvTVaYiE4AnuVfZ6wIueUdzudE/X8=;
        b=kZ2yaeAi7bum9MaKKD6+88hp9OejiTKJvt2flckbDXlMDwgbAkhTPRcRPoaQQffp5A
         t+lZfZTzlXk4XcdBXOCIOGb72h8YZ7uPkEt1FxEJ2GkyPijU9EQtxp849bgsoqUngANc
         yE7khI9UkQgavPH+iy0ZfZR0F9ArXi0SSXNODjZ6yA3Vo+CJrPRsCJbjcN03fyidiziq
         LUnpEfepppGUtnJenhtmjIyKHr7tJ/kNIm+AMtcPStYtFXEq2OgUQ2VGGRhS32j90GQS
         Nt+RlEvWU5vqW9gflHA8fE/lo7076PSWaDS12T7e00lQlPyh+uyaEdrc0ems+Rd4o7Qr
         bHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766390496; x=1766995296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v8zLCGtUEy59h/vvTVaYiE4AnuVfZ6wIueUdzudE/X8=;
        b=Q5DeOMWBabp4k4ZnoCRGjsgnivQIMNBfswc2uKmuPBgDv7uKlpzV5Q23uf+g2/KeYM
         z0BCnokM1Fo8OryDLPnNmjS6iLpUKGxwevWie+8BhqWyvJeSjTdBVG00LKXVyFoyqrEF
         KwWqqsjIyo5n2Qgko7BWzDD706enRMqfL2+EfTKr8mz8j64kPW3Lvzk1HPliOjMJH/tx
         rzldcdzPTQ3VDRd9WKoYx84mUeagHLknT6EghmiUvH/6Ny1ZGOHUiokpgiHL8m//ZNtb
         MC79YRC3M+piGmw/WQmfrKmP38pSQJNWhFCFe1VGTMvvsRfqom/FenBRFHcCQrAQQdtN
         qiZA==
X-Forwarded-Encrypted: i=1; AJvYcCUVYspjlqrfRvh9upLxhzge8Rhe2XuTITpj0SP2iEqGXo1MNyfzXa7AXUebFO/4dcIT8r8JB0EH7PBsm5Bmzi0+c/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCbhk7DhLueB6cqLf2a2yVvoMTUsgGe/ZvvPmFCWO+wk/UhlVb
	pcJNFy9VTddP8Ssv35HwyyjDYiEC4Muk1ZMPZOLdd/Kk9vSFuWmOkn7J
X-Gm-Gg: AY/fxX7qTDJsYNPnZ22GIf7uyFsg8cS1pS3rhw62Vwa5dxNCW6D8u62T23akeev0PFX
	v9YoT9U2guNE8LfRj1kQlaSuRfweUFNuZR9zvmudMTstNpXCLUZZIdHyQ/h+sO7h/h4sexLIhek
	tcHfmeg9bsf9xc1gopT2oi+wrpRxXhYnT4nz+wyL9zuwWFEQUKcIgyA8RefxtK2UBwG0SNjRGj8
	3O9CWDNFa65+IDfoMc2uBwT5mjlcpsGCOS3tOR9k2LV5kpGAGGvuewSELKkTMUa2B1Duz1+gNu3
	kK9DQCej1KY0hzNemoYZrDvuDIEDdeIGfz+N9L4jtoEHSCmdB3YQtSR9Ub8uHyVnqzdv0VTqwbQ
	hfXHbbyxtDn9jI5w3U429Q9XfW7NZlB0Z+Wuv01Y8NbW+rqeoItY+RfNiFzKWvVrLezBrY4BdGg
	cJKupH7CtZqSP1lhe2lYh+TQL1nSPdbn8VrqI=
X-Google-Smtp-Source: AGHT+IGRVyFERy7XokCmRRlYiNa0pF4cWj/sV618kkaysFWs1qFh/tkntU/7uvjqRuWTOwS1Q9Ei1g==
X-Received: by 2002:a17:903:fad:b0:271:479d:3dcb with SMTP id d9443c01a7336-2a2f2212bc9mr111129865ad.6.1766390495794;
        Mon, 22 Dec 2025 00:01:35 -0800 (PST)
Received: from mi-ThinkStation-K.mioffice.cn ([43.224.245.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c82ab4sm89961165ad.32.2025.12.22.00.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 00:01:35 -0800 (PST)
From: liujing40 <liujing.root@gmail.com>
X-Google-Original-From: liujing40 <liujing40@xiaomi.com>
To: rostedt@goodmis.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	liujing.root@gmail.com,
	liujing40@xiaomi.com,
	martin.lau@linux.dev,
	mhiramat@kernel.org,
	sdf@fomichev.me,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: Re: [PATCH 2/2] bpf: Implement kretprobe fallback for kprobe multi link
Date: Mon, 22 Dec 2025 16:00:46 +0800
Message-Id: <20251222080046.2312024-1-liujing40@xiaomi.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251218160925.3c02a721@gandalf.local.home>
References: <20251218160925.3c02a721@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 18 Dec 2025 16:09:25 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:
> On Thu, 18 Dec 2025 09:53:16 -0800
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> 
> > > +static void bpf_kprobe_unregister(struct bpf_kprobe *kps, u32 cnt)
> > > +{
> > > +       for (int i = 0; i < cnt; i++)
> > > +               unregister_kretprobe(&kps[i].rp);
> > > +}  
> > 
> > Nack.
> > This is not a good idea.
> > unregister_kretprobe() calls synchronize_rcu().
> > So the above loop will cause soft lockups for sure.
> 
> Looks like it could be replaced with:
> 
> 	unregister_kretprobes(kps, cnt);
> 
> Which unregisters an array of kreptrobes and does a single
> synchronize_rcu().
> 
> -- Steve

Thanks for the suggestion. I will refactor the loop to use
unregister_kretprobes() for a single RCU sync.
