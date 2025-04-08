Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D8C205ABF;
	Tue,  8 Apr 2025 16:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744129912; cv=none; b=rIECgvc76Rwy0+XWuulge7omUwl1WgAztGKqjjL1OJy376HY58K95fjPAXMiWtNzuCiW/YwHGDl7ZP3EdLkMZAM+B0KRx+RAyY+dLcmHVQGSQ2IIT3/VsWPL95ypRpBeqOpUAUCewy5S6G5zas1vltOUJqA3G1adIBA+i+nDqmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744129912; c=relaxed/simple;
	bh=WoKJv1CvGA3VzPscbwwMn2XrUUm+q1oE6NfexTf05CM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GL9ebkWtK55Q7nI8BuRvThEVUgfI2qwwIe5xiKdyKQf85ZrMHgG9XYD9jAzeznqik8htfXsaonubU7v9p05LWxKfpj1yRGDIF05Cpr4uU+YtCVLR8NiqqAll56i2IoeErb5gzPhIZQcJ9SaJUfWyLy4AoPUt6JJ7eUTC2Rhco7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1438C4CEE5;
	Tue,  8 Apr 2025 16:31:49 +0000 (UTC)
Date: Tue, 8 Apr 2025 12:33:06 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andy Chiu <andybnac@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mark.rutland@arm.com, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 bjorn@rivosinc.com, puranjay12@gmail.com, alexghiti@rivosinc.com,
 paul.walmsley@sifive.com, greentime.hu@sifive.com, nick.hu@sifive.com,
 nylon.chen@sifive.com, eric.lin@sifive.com, vincent.chen@sifive.com,
 zong.li@sifive.com, yongxuan.wang@sifive.com, samuel.holland@sifive.com,
 olivia.chu@sifive.com, c2232430@gmail.com
Subject: Re: [PATCH v2] ftrace: properly merge notrace hash
Message-ID: <20250408123306.5477f30c@gandalf.local.home>
In-Reply-To: <20250408160258.48563-1-andybnac@gmail.com>
References: <20250408160258.48563-1-andybnac@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Apr 2025 00:02:57 +0800
Andy Chiu <andybnac@gmail.com> wrote:

> The global notrace hash should be jointly decided by the intersection of
> each subops's notrace hash, but not the filter hash.
> 
> Fixes: 5fccc7552ccb ("ftrace: Add subops logic to allow one ops to manage many")
> Signed-off-by: Andy Chiu <andybnac@gmail.com>
>

Thanks.

I'll apply this (currently testing it along with other fixes), but I
realized that this isn't working as expected.

I did the following:

  # trace-cmd start -B foo -p function_graph -l '*lock*' -n '*clock*'
  # trace-cmd start -B bar -p function_graph -l '*sched*' -n '*time*'

And then looked at:

  # cat /sys/kernel/tracing/enabled_functions  |grep clock | wc -l
  176
  # cat /sys/kernel/tracing/enabled_functions  |grep time | wc -l
  37

Which means those functions are still having callbacks even though nothing
is tracing them.

What needs to be done is to filter out the filter ops from the notrace ops
before adding them to the main ops.

The main ops shouldn't need any notrace hash unless all the subops hashes
are the empty set.

What needs to be done when adding a new subops is to:

Copy subops filter hash:

If subops filter hash is not empty:

1) Remove all the nohash functions from the copy.

2) If the main ops notrace hash is not empty, remove any of the functions
   in the copy from it.

If subops filter hash is empty

1) intersect the notrace ops with the current notrace ops

I'll write up a patch on top of this one.

-- Steve


