Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3E71514F6;
	Thu,  3 Apr 2025 16:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743698379; cv=none; b=QDLhwVJVrFmvNNc0QDIsR1nAJgL25drsfZqV8UeyMylLptpfVrnsjcZweWxP4X9q/n2Xe/APpxYLRo/CzcAzeNA52aTnPesjag1fllPsr4VGQ6HS+wbYiv/DxJZq7RG12AnRkUd+IdHdXZTgIH+5of63EitcDSy7G4BXTHErCWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743698379; c=relaxed/simple;
	bh=QsquTBzgOmkr9/ysxz/GY+SPh+eIH8M6tMImN0n3NDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FiC6rkoKTMOgl42usyTs0YSZM/9C7CfzOJwaogB+8HLsv+DyBW+SqC5W0sQg4jwdwkNN1OXCwSxWVYksi7Eox/Z1Fz16GtqAJX1mKkLWPXpSJQaoBcthwyaqpfTweiAyI+HiCkEoCvd6HRfEopd2jddy1uKGH1HoWeg1sFcy5AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D1J6WKnf; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1J6WKnf"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e5e0caa151so2061404a12.0;
        Thu, 03 Apr 2025 09:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743698376; x=1744303176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QsquTBzgOmkr9/ysxz/GY+SPh+eIH8M6tMImN0n3NDc=;
        b=D1J6WKnf5ui3TeIC/R1Awes0mMLdZQOKxBYRiRJmwFvzwfHt0Fw6F2U57d8dACxlk1
         ndIHVEHv7NIzwR7Ira1YpKVxw1C1GfZX72NzV85rI9fySBC95i/+Yc5hMX25oQsi4LDE
         VYzw+cz0b9r+ME7Ce9RCy1zxxCOasZLM+w877jAw6N7tu4aIuI1rXSjf3D5nDnAmH1WA
         fD4+jRsGO9v3o3uATT9q2rSIC2IxPxdKcV7z5shjIetnEg3gzIY+b5BfTTPpJZ/SGJVR
         GgRVn16yyq4Z4vyU/MZ9zMHejEfrYptIowla69WdRqduEZHqXy4Teg28Bk+Y9TxDHFAx
         ahUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743698376; x=1744303176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QsquTBzgOmkr9/ysxz/GY+SPh+eIH8M6tMImN0n3NDc=;
        b=LS+l4wn5G5hxKxAONMZDqQO+iect84AcB+pQFOllTaWx3AHwLBUDRG1FxjqjJInhpd
         RV0spxw8WwMOGTPbtN5z+wTEiK74oTq6Otzhwh1+MjIPS2G6Jfqxp8haRfTiSOpoO3Ls
         j8E3HOsamIs0tRULhFo5/mkOJ4cGPgBQa5NwA9fxDnMyP8/rCwuu8Pnv7c+Hbsy2pIfk
         CliLQBs/MfYTZt5AjQ2aq8cPCjspGDbdA7zGc9qvQzY6Or+8QgLflJSmq0aWrSWcI0FI
         ByrFbzAVnkNX6bYX+WmETGEhzRT3fN8FEgL+pDISt3IDQa0iwW3iWLDAWR5wrvLDbRhK
         1t2g==
X-Forwarded-Encrypted: i=1; AJvYcCUabXrTNqIPBkJIpMGfNOD4hWOVkwqVjL1NGds/7SsxWmZug/VMt0RgKQlg3ukyi3STFjiBA2ijJgwLYqY=@vger.kernel.org, AJvYcCWePkM8nltoqT9xCk3YDJDK0TJWp+rCXjhIHVZcyvp0ukVxcjF0048cCaTFQvcT1SWOFMvGUMO8reb8Xj0PMAwgr9m5@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrw+HKcqchxbr6BVSRo9Ml08yCytY8sGN48VlcRrL4iZAh4q31
	CmlOy0X0t3gKVqBPvV22sdSsW/hSbQ6A3+eN1zf10s7kBJ22wg6y/+Gm+V2iDbPA7nSp7NTNRlh
	QHIqHz8pvXUH2XzFh4BB/PjcZtws=
X-Gm-Gg: ASbGncvk/PgiYBHoT5QVFsfLqzzgnDToBuKgJzQd2vEzh3D/YI+VJQjw0dvi6KoFJHl
	AJ7Lfxg3qnLZ5gpwyEW85Ise5srole1cm0+6qI/9LFATn4oWgM2rOdeq14Yyav3v5xaJbFHrlk/
	8KH9vWY4Ht5dv1QaAwrqIKdqrA
X-Google-Smtp-Source: AGHT+IHwXZTdMgLzXp7QCCwNxDBR2dVogVg7DgrbpojvC2yqGK8Fv9w9GNmWMTZeRDGVJpYZV7xR1c970wAge9hCFQQ=
X-Received: by 2002:a05:6402:42c4:b0:5dc:94ce:42a6 with SMTP id
 4fb4d7f45d1cf-5edfd9f795fmr19692799a12.22.1743698375723; Thu, 03 Apr 2025
 09:39:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331223516.7810-2-sweettea-kernel@dorminy.me>
In-Reply-To: <20250331223516.7810-2-sweettea-kernel@dorminy.me>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 3 Apr 2025 18:39:23 +0200
X-Gm-Features: ATxdqUEt9Pz10N02XrpS39HolmBCJKRettgtdx6EOudxklUyVCrn5fPBZffA18k
Message-ID: <CAGudoHF_sD0T9JHSpJyJiBqKd2cO+5jFjvNBpEx4Mp+uK044PQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2] mm: use per-numa-node atomics instead of percpu_counters
To: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc: Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Martin Liu <liumartin@google.com>, David Rientjes <rientjes@google.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
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

On Tue, Apr 1, 2025 at 12:36=E2=80=AFAM Sweet Tea Dorminy
<sweettea-kernel@dorminy.me> wrote:
>
> [Resend as requested as RFC and minus prereq-patch-id junk]
>
> Recently, several internal services had an RSS usage regression as part o=
f a
> kernel upgrade. Previously, they were on a pre-6.2 kernel and were able t=
o
> read RSS statistics in a backup watchdog process to monitor and decide if
> they'd overrun their memory budget. Now, however, a representative servic=
e
> with five threads, expected to use about a hundred MB of memory, on a 250=
-cpu
> machine had memory usage tens of megabytes different from the expected am=
ount
> -- this constituted a significant percentage of inaccuracy, causing the
> watchdog to act.
>
[snip]
> I think the important part is that this improves accuracy; the current
> scheme is difficult to use on many-cored machines. It improves
> performance, but there are tradeoffs; but it tightly bounds the
> inaccuracy so that decisions can actually be reasonably made with the
> resulting numbers.
>

Even disregarding this specific report, a prior patch submission
points a result which is so off that it already constitutes a bug:
https://lwn.net/ml/linux-kernel/20220728204511.56348-1-ryncsn@gmail.com/

So something definitely needs to be done to improve the accuracy. But
that always will be a tradeoff vs update performance.

This brings me to a question: how often does the watchdog thing look
at the stats?

I wonder if it would make sense add another file to proc, similar to
"status", but returning *exact* values. So in particular with percpu
counters it would walk all CPUs on to generate the answer.

Then interested parties would still get an accurate count and not get
in the way, provided they don't relentlessly do it.
--=20
Mateusz Guzik <mjguzik gmail.com>
