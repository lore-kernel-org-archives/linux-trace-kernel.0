Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968BE12CDAE;
	Tue,  8 Apr 2025 07:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744098391; cv=none; b=dU4opwW/6m9Ux9Bx4fVj/ioPBDtzaamVXNg5ZabPyXoK//rScyFfDIDRpV+b9R64Io06ocg+8CJfXmUUf6Quiyaj0XfjaV9OX6YdTZRT3Q09EGSPGwLuK+toivNIFVw5vpZPCca+DNx94OvZJlAbyEcWp85/kOsm8bAA5B3a+8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744098391; c=relaxed/simple;
	bh=CYWLgNMUz1gmoCTVrt8FUVjBZYckyum9T6o9Eaioln4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gTqzgOUmGvzU7IU/d0th+To8w6/ez86G0msY32yK5ZHwxEdjYSa4Oah2IpC26pBmdfuO+v/1tIRn5p//FiIsEmQFhdzSXzZZJ3JSfmRLUADzywvCoSSmk8kjZc9E9n4Yhb5RbLifP4qCkUF6ERgQzxx70OFiC/1+MLdZRMv1SXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XyQLQ8xT; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XyQLQ8xT"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e673822f76so8667425a12.2;
        Tue, 08 Apr 2025 00:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744098388; x=1744703188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYWLgNMUz1gmoCTVrt8FUVjBZYckyum9T6o9Eaioln4=;
        b=XyQLQ8xTk3VMWKkzGctVxVLDtavM4QgjwNOnhWJ6Q1ZHInFUTIRGj6a8IE+9JJNjJw
         cI1JatD6DGiszy07MUdVoV6NIEmdFKvkkC444HxQRrY8kXviwCqOk86Y01RLatUm3o5A
         tlIliT1MSfB30mZYA3tJzf756eVc0LK5Tj9pQ5lP21zdrjGxAZoRg7UtxmnFVAFOZACw
         jG9zu7W5pUR5qJ+eU29dbe9MwQ0XKw6Hw4kbOyBkhB4koYs2svEgUlg1aJbEMYo2ejUA
         TWHRbu51F1MqsdCCurhD2BQBAWJzed6RrPAgBy8zmaY2tRhd/PfyMr3Mkjf+m+60jWxf
         N0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744098388; x=1744703188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CYWLgNMUz1gmoCTVrt8FUVjBZYckyum9T6o9Eaioln4=;
        b=T3uX1GRAoLM4g7Jv66rwC6M6/p2mez1iS+dKc7kRhVy/OjBl2ZMTqzUUVuMu3NolCh
         eM3uW2ID+vmn/AEJ5MZdnFpBOl+Fy6mYbB9P4PH4VtzZ/xVtfYpfxxnjhay8bnhOowm2
         FZ0HrHd8SXSMyqPluUIu9NroLyg39yuxqBaxocNKxS3/K/Rz/VzEv2RV9QogmqCDvt2L
         2YsrBZmsFzZRT7GH3BpfVkYVO70dnctj/qdOTwYFcU053OfTkKYwzaG5StFoK1AdaB2W
         adJYRaoKZKjtiE/mgGa5XkA/Twgqp3w1eBLp+gdhaBTpdinM2fE4MtsC6h3pdrwSHtB0
         /m4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUYDH5DGMP8iSr8R4UfOl97Y8FQmAlVvWy46x4UB4BWGZFz+PItyF4m5KjVSJ6Db6tgINrK0nFm5poSM+Y=@vger.kernel.org, AJvYcCUmYPvQrjp54ouEcPFaw2DIQY+gjG3cRxofvQL00wVtdtAP+Mye682S+HNRK0TAYwmaMWHFvSfSW8Mh1gzv/Q1D2chV@vger.kernel.org
X-Gm-Message-State: AOJu0YzOEoMenkgSIECEDsY1KkLTbrPJhMfFdU58hSckDa2/jQFY5hmn
	WvE73SebqgZX90XnZcb6PoDxeUxL8Iu4PIrMbIthN13LfOwkLERteIZM3ZRZ+Ww78o3yczeZ71N
	9ulyQ6zK/vQseCcL7iyGA21wlJcg=
X-Gm-Gg: ASbGncvpsbflzkQbL9FH5t+qTAo9VL3RNLrTyq4JQXXXxOnWi/D68VYxlZitiaHU5qf
	h4LWMNi8OCZoX86hKqcpcR20F5absfmSQTeZTsVts8UNzTETHvNhod4jvUy4a5aF/A+xsGyA+lA
	UupyAjJZNXjy0vAFV5VIDcOoZ6
X-Google-Smtp-Source: AGHT+IFmG6MLnSUDQL0TyguKXOKi9sZPAf8BJ1l0ld/2h6vDza1UJsGTRfqurp3q32bdQUAB0t99uhb/N1ovjRQpxIM=
X-Received: by 2002:a05:6402:1ece:b0:5e6:466e:5866 with SMTP id
 4fb4d7f45d1cf-5f0b6606682mr13812283a12.25.1744098387736; Tue, 08 Apr 2025
 00:46:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331223516.7810-2-sweettea-kernel@dorminy.me>
 <CAMgjq7AroDCKTfJzJRr++8H2b3eTd=MeUqwkPUX4ixRVqZw6-A@mail.gmail.com>
 <CAGudoHH7OUHG2HHrjzqkiqgYXzLEtovCptHpxkyVNPwSMHWfrw@mail.gmail.com> <CAMgjq7C_W3dfYQ6DJT4QCza1DCtCE7yUdiManQSxCKOENxTm_g@mail.gmail.com>
In-Reply-To: <CAMgjq7C_W3dfYQ6DJT4QCza1DCtCE7yUdiManQSxCKOENxTm_g@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 8 Apr 2025 09:46:15 +0200
X-Gm-Features: ATxdqUEpX6XFuXeA6vg0-rN_JsZ2MEwWgX3OKplmGxlA9qwyfA2V1kLMwyG-s0c
Message-ID: <CAGudoHHQ4y0Z_A0yzpfim_wGFVUuF3NaLgNtWUiquiCby6Ppkg@mail.gmail.com>
Subject: Re: [RFC PATCH v2] mm: use per-numa-node atomics instead of percpu_counters
To: Kairui Song <ryncsn@gmail.com>
Cc: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>, Andrew Morton <akpm@linux-foundation.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Dennis Zhou <dennis@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, Martin Liu <liumartin@google.com>, 
	David Rientjes <rientjes@google.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Sweet Tea Dorminy <sweettea@google.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Wei Yang <richard.weiyang@gmail.com>, David Hildenbrand <david@redhat.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>, Roman Gushchin <roman.gushchin@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 4, 2025 at 6:51=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrote=
:
>
> On Thu, Apr 3, 2025 at 10:31=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com>=
 wrote:
> > Note there are 2 unrelated components in that patchset:
> > - one per-cpu instance of rss counters which is rolled up on context
> > switches, avoiding the costly counter alloc/free on mm
> > creation/teardown
> > - cpu iteration in get_mm_counter
> >
> > The allocation problem is fixable without abandoning the counters, see
> > my other e -mail (tl;dr let mm's hanging out in slab caches *keep* the
> > counters). This aspect has to be solved anyway due to mm_alloc_cid().
> > Providing a way to sort it out covers *both* the rss counters and the
> > cid thing.
>
> It's not just about the fork performance, on some servers there could
> be ~100K processes and ~200 CPUs, that will be hundreds of MBs of
> memory just for the counters.
>
> And nowadays it's not something uncommon for a desktop to have ~64
> CPUs and ~10K processes.
>
> If we use a single shared "per-cpu" counter (as in the patch), the
> total consumption will always be only about just dozens of bytes.
>

I agree there is a tradeoff here and your approach saves memory in
exchange for more work during a context switch.

I have no opinion which way to go here.

> >
> > In your patchset the accuracy increase comes at the expense of walking
> > all CPUs every time, while a big part of the point of using percpu
> > counters is to have a good enough approximation somewhere that this is
> > not necessary.
>
> It usually doesn't walk all CPUs, only the CPUs that actually used
> that mm_struct, by checking mm_struct's cpu_bitmap. I didn't check if
> all arch uses that bitmap though.
>
> It's true that one CPU having its bit set on one mm_struct's
> cpu_bitmap doesn't mean it updated the RSS counter so there will be
> false positives, the false positive rate is low as schedulers don't
> shuffle processes between processors randomly, and not every process
> will be ran at a period.
>
> Also per my observation the reader side is much colder compared to
> updater for /proc.
>

Per my comment, the read thing happens a lot for mmap and munmap so it
cannot be taken lightly. You can check yourself with bpftrace.

While I can agree vast majority of processes are not very thread-heavy
and vast majority of machines out there don't have hundreds of cores,
this does have to behave sanely for the cases which *do* exhibit these
conditions. For example a box with > 200 cores and 200+ threads to
boot, all running on the entirety of the box.

In your patch as posted fetching the value will force the walk *a lot*
and is consequently a no-go. This aspect needs to be dealt with for
the patchset to be ok. Otherwise few months down the road someone else
will show up and complain about a new slowdown stemming from it.

--=20
Mateusz Guzik <mjguzik gmail.com>
