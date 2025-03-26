Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FAE24E4C4;
	Wed, 26 Mar 2025 21:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743026078; cv=none; b=rTEBaZBx5KMgoHR9AE8hV1uMQslFSlajbT49nxk0uLFyY+CtJwYpHXjUkir7CeS3BnTgRrqCdhE9iqXkwvskHUQAap8XZp6b64+rQh9EtWocpzP3fmazXmkMzGmFH/AxV9HgvDuTlbJFS58kpkKJbJ9vgcqXn+88Lr01WwoQjNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743026078; c=relaxed/simple;
	bh=jbMYlr1cWWvD7vUKVAHtSahlNtdvwju1wRUPjyYyqb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZMVNwaDi3++hbTSb0ytkp6KvLObLu2+v965vtKKHdrspzTYXTCponzFXd7gvW4INhz4O8z0+xBbhRKJY0UTFJVARJmlUI/Fl/aCBJG2g207bNcED+tWDKk6W8w/BqLvb4z4y9y+8qC1YZu2+eLnJ2PQ2nQQcwoJGYSyIEZl8wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cWIMN5Br; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWIMN5Br"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cfb6e9031so3106275e9.0;
        Wed, 26 Mar 2025 14:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743026075; x=1743630875; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7bWRiMn3i2Cx/2MWZmhpCx5tvwp0xN6YJAcrqwLq/M=;
        b=cWIMN5BrRCR/4//C9ObV0ADxLt8mDMwqbxQxM6P8pRBcFO9DLROlQ7BFIxuM1Ipsrr
         icwMsbHZ5IF24xUejRXDbbwLr0YlBeu47lKP1BkMRnzbJr2vPyGMLRdQIfm/rnJqCqqa
         +80C4aTaIeKbfTUxJ9lhlQKpRxv3bha1MCaeJvISoEVWhX2sbWa0fU4AqPQXD3JORekW
         XY8pl1OsAEVVs+xe0S9QANuLMAwyvlTh3/el9bSZZ3q1/z5p5cvPydeoiR4JSikWtZZl
         b1sNJyCu2nVhIi8eRV9SzXcxQfe1GVLQ/Oe5SX6Fg+zIiprYiOkXJYKGshrnXnkgsZyJ
         LabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743026075; x=1743630875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7bWRiMn3i2Cx/2MWZmhpCx5tvwp0xN6YJAcrqwLq/M=;
        b=xGwIA1TrWa3nEmuPm3Oe62PrpVkHTsK6flf7/mKTX90JeSJVq3vyTLlepos1iTlTwk
         lSV+RPbVjOW/WL7XA01RU1cg8AorVffqTL638DOsDDnpbYN3HtyLYkgPK+/ghqAJurRQ
         WEnSlEaeHm5qI5Xd040yV7BK6GMcNHgyXusY4d7CL7+abTppKXxE9jsCKt+CtCIcjYsm
         UwQN5ICFjjIQHUZ0pIgo2frq6HRfTdvF1KEY9ljn9rYYmkWr5nMJ/DJ+3sFTJBfS5K6S
         iVIEzBAbCt6VYYcyT/NNziXyRMtvSl4rnZ/0nR7/+ZmqK9GdoX5wVOKpFjHHB+GtIc73
         ZlIw==
X-Forwarded-Encrypted: i=1; AJvYcCUQ+appjfcWb1nxzKKOBbgCG13+HlNWkmbGoZifBvIl1VwHrFQvb5l3n+ivO1CYCwQFWT9nvHL3tcB59bY=@vger.kernel.org, AJvYcCXm7VJo7wTOC+z2zTTT3wxul238kfXXoxuerLEiyCPM1kF1mYVc7WXz8qeKukZWvBIAJTUosXkd9T96eIOyS3rhaLAG@vger.kernel.org
X-Gm-Message-State: AOJu0Yy30clB4PL6n495ACGkOqhN4LIhij5L0L7aVu3yO6uVEHIF+C1Z
	ILV6+GpTUdKXX4nt1zbF04F8ILhVPW3ZjKadMT7Tn8iEpD5ovfAK
X-Gm-Gg: ASbGncuvYCbQcQLREyKDBy8QVrZ/qVJuyz+JxijJH0XSbRirvykgnoYo8WJlxhLK1bZ
	090AFgHBHpwTj+hbA8GXmLKwf0Gmwh7ndKVi4mlJaAmDFZDezCfuZRqNR4LE32/X6+mSSjrNx+c
	kumlz8eJYh/YSOop4Db73+9+c2IdLgGYrHJ7DFU/BIpy1rO/UijUZy+LtizU/+YFTBl2qPg4xQa
	kq+4vYlxcPG4WrvlXYIJXDGW4ied7t+ibyow66tovm78gSro0kpqXMT2WhAAjWdRHq7QOt043x2
	y0CFUZP1SKHziqxBNwIS5ZYDIYyQrKoVs9c3cUry4LQN81g/Jv4fyF2AFtHM
X-Google-Smtp-Source: AGHT+IGIq5a1efTx2UlvGIV3W/NrYSnjJ1SgQ0JCgVxcOr8nge55s3HmwsMUiw6kMpxpXUhhuuZbAg==
X-Received: by 2002:a05:6000:4210:b0:38d:d666:5457 with SMTP id ffacd0b85a97d-39ad1784627mr849206f8f.42.1743026075141;
        Wed, 26 Mar 2025 14:54:35 -0700 (PDT)
Received: from f (cst-prg-80-192.cust.vodafone.cz. [46.135.80.192])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9e674fsm17677985f8f.80.2025.03.26.14.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 14:54:34 -0700 (PDT)
Date: Wed, 26 Mar 2025 22:54:23 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>, 
	Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@linux.com>, Martin Liu <liumartin@google.com>, 
	David Rientjes <rientjes@google.com>, Jani Nikula <jani.nikula@intel.com>, 
	Sweet Tea Dorminy <sweettea@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Christian Brauner <brauner@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Wei Yang <richard.weiyang@gmail.com>, David Hildenbrand <david@redhat.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Matthew Wilcox <willy@infradead.org>, paulmck <paulmck@kernel.org>, Yu Zhao <yuzhao@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Greg Thelen <gthelen@google.com>, shakeel.butt@linux.dev
Subject: Re: [PATCH] mm: use per-numa-node atomics instead of percpu_counters
Message-ID: <n6lvd6chmhpc2cdzjwwvetwvpkqxc5ajqdzhcuzc2fajveo5qv@3u4r4y3sa2qx>
References: <20250325221550.396212-1-sweettea-kernel@dorminy.me>
 <67e2a6a1-8c9b-43d0-b960-10cd47c08873@efficios.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <67e2a6a1-8c9b-43d0-b960-10cd47c08873@efficios.com>

On Wed, Mar 26, 2025 at 03:56:15PM -0400, Mathieu Desnoyers wrote:
> On 2025-03-25 18:15, Sweet Tea Dorminy wrote:
> > From: Sweet Tea Dorminy <sweettea@google.com>
> > 
> > Recently, several internal services had an RSS usage regression as part of a
> > kernel upgrade. Previously, they were on a pre-6.2 kernel and were able to
> > read RSS statistics in a backup watchdog process to monitor and decide if
> > they'd overrun their memory budget. Now, however, a representative service
> > with five threads, expected to use about a hundred MB of memory, on a 250-cpu
> > machine had memory usage tens of megabytes different from the expected amount
> > -- this constituted a significant percentage of inaccuracy, causing the
> > watchdog to act.
> > 
> 
> I suspect the culprit sits here:
> 
> int percpu_counter_batch __read_mostly = 32;
> EXPORT_SYMBOL(percpu_counter_batch);
> 
> static int compute_batch_value(unsigned int cpu)
> {
>         int nr = num_online_cpus();
> 
>         percpu_counter_batch = max(32, nr*2);
>         return 0;
> }
> 
> So correct me if I'm wrong, but in this case the worse-case
> inaccuracy for a 256 cpu machine would be
> "+/- percpu_counter_batch" within each percpu counter,
> thus globally:
> 
> +/- (256 * 2) * 256, or 131072 pages, meaning an inaccuracy
> of +/- 512MB with 4kB pages. This is quite significant.
> 
> So I understand that the batch size is scaled up as the
> number of CPUs increases to minimize contention on the
> percpu_counter lock. Unfortunately, as the number of CPUs
> increases, the inaccuracy increases with the square of the
> number of cpus.
> 
> Have you tried decreasing this percpu_counter_batch value on
> larger machines to see if it helps ?
> 

per-cpu rss counters replaced a per-thread variant, which for
sufficiently threaded processes had a significantly bigger error.

See f1a7941243c102a4 ("mm: convert mm's rss stats into percpu_counter").

The use in rss aside, the current implementation of per-cpu counters is
met with two seemingly conflicting requirements: on one hand,
synchronisation with other CPUs needs to be rare to maintain
scalability, on the other the more CPUs are there to worry about,
the bigger the error vs the central value and the more often you should
synchronize it.

So I think something needs to be done about the mechansism in general.

While I don't have throught out idea, off hand I suspect turning these
into a hierarchical state should help solve it?

As in instead of *one* central value everyone writes to in order to
offload their batch, there could be a level or two of intermediary
values -- think of a tree you go up as needed.

Then for example the per-cpu batch could be much smaller as the penalty
for rolling it up to one level higher would be significantly lower than
going after the main counter.

I have no time to work on something like this though. Myabe someone has
a better idea.
