Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D870F1A08BC;
	Fri, 11 Oct 2024 17:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728667427; cv=none; b=DiB+oM9c41Ziyu4M787n5uq72Ch9fWCtnmwaOvo/JNYxqbkW3Or7WDlRcQ4Lso8MpOOMn8NrrXRoYzUVzrLSXzWpbZZTKNBgNsGMIrf283McQflMOpFB35thk9N5hLtEr/og9GV78lRo9vluamqifG1COh1HFofToQUKIXlpgK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728667427; c=relaxed/simple;
	bh=IaFR+n39iJsRDcaFAJ0z2Fv8ILg3yE7ynsdexLRlcBo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DU/sKxByDR7Haz8G8h2LClrHp2g6mdW/f4oQCLacYXvWOnmIEnnRDNuQ/UpE0b8M8liRIV0VjI+9nUADQB8Acl9H/izAR/yDnJCzO+cTCys8iH+MWFSuuUgI32c82+LMMGY+W7cSYDmEQnmlpCmMD83FRvEHtSc+Pq3Ilpvnf/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A721CC4CEC3;
	Fri, 11 Oct 2024 17:23:46 +0000 (UTC)
Date: Fri, 11 Oct 2024 13:23:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: tglozar@redhat.com
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 jkacur@redhat.com, lgoncalv@redhat.com, Attila Fazekas
 <afazekas@redhat.com>
Subject: Re: [PATCH 1/2] rtla/timerlat: Make timerlat_top_cpu->*_count
 unsigned long long
Message-ID: <20241011132356.28c48902@gandalf.local.home>
In-Reply-To: <20241011121015.2868751-1-tglozar@redhat.com>
References: <20241011121015.2868751-1-tglozar@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Oct 2024 14:10:14 +0200
tglozar@redhat.com wrote:

> From: Tomas Glozar <tglozar@redhat.com>
> 
> Most fields of struct timerlat_top_cpu are unsigned long long, but the
> fields {irq,thread,user}_count are int (32-bit signed).
> 
> This leads to overflow when tracing on a large number of CPUs for a long
> enough time:
> $ rtla timerlat top -a20 -c 1-127 -d 12h
> ...
>   0 12:00:00   |          IRQ Timer Latency (us)        |         Thread Timer Latency (us)
> CPU COUNT      |      cur       min       avg       max |      cur       min       avg       max
>  1 #43200096  |        0         0         1         2 |        3         2         6        12
> ...
> 127 #43200096  |        0         0         1         2 |        3         2         5        11
> ALL #119144 e4 |                  0         5         4 |                  2        28        16
> 
> The average latency should be 0-1 for IRQ and 5-6 for thread, but is
> reported as 5 and 28, about 4 to 5 times more, due to the count
> overflowing when summed over all CPUs: 43200096 * 127 = 5486412192,
> however, 1191444898 (= 5486412192 mod MAX_INT) is reported instead, as
> seen on the last line of the output, and the averages are thus ~4.6
> times higher than they should be (5486412192 / 1191444898 = ~4.6).
> 
> Fix the issue by changing {irq,thread,user}_count fields to unsigned
> long long, similarly to other fields in struct timerlat_top_cpu and to
> the count variable in timerlat_top_print_sum.
> 
> Reported-by: Attila Fazekas <afazekas@redhat.com>
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>

Thanks, I'm applying these, but could you or someone else create a test
directory in rtla and even rv that tests this code. I just examine it and
run some basic operations, but I have no idea if it is really working or not.

Having a utest directory or something would be really beneficial. That way,
I can at least run that test before I push it up to my tree.

-- Steve
