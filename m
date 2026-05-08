Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BD23D5670
	for <linux-trace-kernel@vger.kernel.org>; Fri,  8 May 2026 18:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778264773; cv=none; b=V7BULz0x7WUUxO+9ClWFiTxrjD4ZUtmTpUzSXCmuz0uOYttbwOI81j7qSVT4cr93WlN7D42tVW4cpY3JOvfTM3o2g7YtQMIx21eHuMkaRZrsFtMNYfccOTEs0frVdMUlLREXCQxxasfxBw2EGi/Jvj6lajy9PnIcLX5tOUF7yiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778264773; c=relaxed/simple;
	bh=gPt2p5mRydIx09aB5eoi5h+EjR87ILB07pmtiyqKD6c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gqfNXhtwHfPQoj8RCQszeEdYkuIEfEMcivYhR7u391l1zt9V0YRxXW86lIa/h2GM+TQZjpKULWlWwuTX85hdYVIWO0yQ/Bc/8lfBEZK0bGN8GbGaMwgOaEB+Z8uCCmpjHiJE9jtlFm9lGn22310fpLuhziUkfqoCUNYQWcAri60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UH89eDTW; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UH89eDTW"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43fe3e22e33so1420141f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 08 May 2026 11:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778264770; x=1778869570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nadJ4F3fO0o2IbMhIzDipftu6czfRb7SQ9fGD7WtGtQ=;
        b=UH89eDTWQh9OmS5hUj/dgbTfi3H7wYOPLAD09tyOadceQmuQ1jSW8ecpWt6e65vzgO
         dUPuw2rKBsNlxygqwzKdECs3V10qe9a4JTkf9GaWDDLwqBqvoMNLKQ2z3FbIsAL/Xdkv
         h7/yFvPjCarOyc2epdk5HYzixl3aB5dJ7/MAOl6vWwy/FkzEklri+HmlVblgJNeywYs3
         jY4s5DAbrSwYKbkt8b7zGAZBoJzpLJWvDWX8ghQ6HhC4QCi71rcwijca/mxruMoHZWW5
         w3gPGRNJQkqEZa35nbPwNKiM05kM5CZ5Ih7Ano8akSmPY2OogTfMOuflpNXAGNBjiHZS
         1bcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778264770; x=1778869570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nadJ4F3fO0o2IbMhIzDipftu6czfRb7SQ9fGD7WtGtQ=;
        b=JiNbwHJt0lFL+zdlKZb5eW/IFplR7FqGDKeNX4nf4U7pdI3z8k6L7FJ5dchhcHgMDl
         eBJaI+PkKZaqDgBUROaVjGTy4l6qAsfC/3F4jc+1ISjJjVKJw7KIKL770FrQepmVgRrI
         Vsg4tpqfByvaB42Re4FHdXlMhdZGiXAsYHglgvkru6NOT1LIwS6f0ppQ8XUfvuFnJEGP
         2EXBqeWaoFJKquRSjyy9UP73zWL0ilVLoaf+j7rU+SjGcCfxD0BO0ou2ooSwlOIY3T8f
         iy6BmR11MnaR0DhpJed9Pwf0WQs0Q8QspjNBZ3ctXU8CCu66OGAswt33sOerYjN/tOmK
         aicg==
X-Forwarded-Encrypted: i=1; AFNElJ85ACaQkwK/ifSIhRxin2F90qQBL0tAGjKbqzFZmTT7s6YC3phpGujneea3WB1j+SB+wP+zgopargUawPmndZypXGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjWEy6RMeAvqrjXnCc9chzjLl6IwIRsA6m5/OTVYunKq7+6k4n
	0ZDhBHBVkewTr8SAfNBYbmnrCxvBkl8repTUb1dAGUSeLiBsr/Z/XVyE
X-Gm-Gg: Acq92OH5cGDsjS7fDBwbyH6VYS1/od8bqNbvJWIOlIX5W1i4sxJ8PFtd97IXa1QEKkp
	A6ilx9AZKjFLLIITMUY/HjRdQx94urQ7fRmTVt5q1gSNnAOFm+hTxzddPm5DSwoRKNUqe2aD2Uk
	gbUIwzxupKivHastYgmZ50dkm5HPqKKomvjguW6MvVhpnI6kkaKEQ0rUWuiGOFTPaR9hz7YPsto
	5BN6KayQCOoiT/hejjy1u0HnqX8Iiz/tQUEL7Xd56d4DqVQ9W2QtBiuRhIYpQMeX130L40Gg6J8
	u0m1wXBmbopOaqBv3EvuqtGZsITvI2S7bk2qVd8NUb6+m+sVraXGVmTkffa97vtntuatrmtuG0J
	Gmp5UTW29qAs3/JIPC014Da2BFBZHmTizHCWn6hiAT/hvdNCbPHdiKhk5RMnAOjLT2VD4gasW2s
	igMfhLi7GhUYNL3jhb0Q0u3T1pOLRCwU3JlX+OZi6alUmI0N243aPi4a8N39WYEAE1
X-Received: by 2002:a05:6000:420c:b0:43d:7508:c9c9 with SMTP id ffacd0b85a97d-4515c5752d8mr22366137f8f.27.1778264770073;
        Fri, 08 May 2026 11:26:10 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548ec6c79fsm6435208f8f.15.2026.05.08.11.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 11:26:09 -0700 (PDT)
Date: Fri, 8 May 2026 19:26:06 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Adrien Reynard <reynard.adrien.08@gmail.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Neeraj
 Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes
 <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, Boqun Feng
 <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, David Howells <dhowells@redhat.com>,
 Paulo Alcantara <pc@manguebit.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 "open list:READ-COPY UPDATE (RCU)" <rcu@vger.kernel.org>, "open
 list:DOCUMENTATION" <linux-doc@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>, "open list:DRIVER CORE, KOBJECTS, DEBUGFS
 AND SYSFS" <driver-core@lists.linux.dev>, "open list:FILESYSTEMS [NETFS
 LIBRARY]" <netfs@lists.linux.dev>, "open list:FILESYSTEMS [NETFS LIBRARY]"
 <linux-fsdevel@vger.kernel.org>, "open list:TRACING"
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] docs: fix repeated word 'that' across documentation
Message-ID: <20260508192606.2423f50e@pumpkin>
In-Reply-To: <1501caea-8cff-4968-aca6-e8d4b20e0e80@linuxfoundation.org>
References: <20260508163759.16231-1-reynard.adrien.08@gmail.com>
	<1501caea-8cff-4968-aca6-e8d4b20e0e80@linuxfoundation.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 May 2026 11:15:28 -0600
Shuah Khan <skhan@linuxfoundation.org> wrote:

> On 5/8/26 10:37, Adrien Reynard wrote:
> 
> Missing commit log in all your patches - I don't patch 1/5 in
> my Inbox.
> 
> > Signed-off-by: Adrien Reynard <reynard.adrien.08@gmail.com>
> > ---
> >   Documentation/RCU/rcu.rst                          | 2 +-
> >   Documentation/driver-api/driver-model/overview.rst | 2 +-
> >   Documentation/filesystems/netfs_library.rst        | 2 +-
> >   Documentation/trace/histogram-design.rst           | 2 +-
> >   Documentation/trace/histogram.rst                  | 2 +-
> >   5 files changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/Documentation/RCU/rcu.rst b/Documentation/RCU/rcu.rst
> > index bf6617b330a7..320ad3292b75 100644
> > --- a/Documentation/RCU/rcu.rst
> > +++ b/Documentation/RCU/rcu.rst
> > @@ -32,7 +32,7 @@ Frequently Asked Questions
> >     Just as with spinlocks, RCU readers are not permitted to
> >     block, switch to user-mode execution, or enter the idle loop.
> >     Therefore, as soon as a CPU is seen passing through any of these
> > -  three states, we know that that CPU has exited any previous RCU
> > +  three states, we know that CPU has exited any previous RCU  
> 
> The original intent might have been to say, "that cpu", so adding
> the missing comma after the first "that" or change "that" to "the"
> would make sense.
...

I don't think adding a comma would be correct.
The clause splits as 'we know that' 'that CPU' and the repeated 'that'
is absolutely correct.
Maybe 'that CPU' could be replaced by 'it'; but it can be difficult to
work out what back references like 'it' refer to.

You can re-order it, as (say):
	Therefore we know that as soon as a CPU is seen passing through any of these
	three states it has exited any previous RCU read-side critical sections.

But just because some grammar book says you shouldn't have repeated words
doesn't mean there aren't exceptions.

The sign writer was doing a new sign for the 'Pig and Whistle'.
Unfortunately the gaps between Pig and and and and and Whistle
ended up visibly different.

-- David


