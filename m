Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416F12EB840
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Jan 2026 18:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769107937; cv=none; b=IWqGpVYPNrQs9C6uhYmgZTsMapINT/JE8sXKr0GmkWAKYdYkHkTY4XYbxLsVCZz43inBOJFNRe06aFTxavRZbq4VzUh2Lv3SM4/AynPgv189lbgISj6my2/+DQKz/RlUlklzDs9FcFC0s+w7PqKOOMubtS6j2Fcm0/6YCaHVX9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769107937; c=relaxed/simple;
	bh=p7QDPgg55RjVmOpJOuHBXK0qFxbkIbuGm9FcitbdG7c=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Rh+EQYgTGulUSUk1ryjFt27O5z5b4j0tI8Cg1RcrcQ3WqT6FlHfPIUHkMpTgrg1KbZxdz8XR0NC1NCaaeB9QxtWctMVFtKeybqckqDEmEu18Cd8SvGzdw4T2zKNw7nCZiaSuKSOFN0AuGCUUilFI0B5KWk8eol1JHua1BYcoVgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=kLHOh/un; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="kLHOh/un"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26273C116C6;
	Thu, 22 Jan 2026 18:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1769107936;
	bh=p7QDPgg55RjVmOpJOuHBXK0qFxbkIbuGm9FcitbdG7c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kLHOh/unMENKI71Mu3xkAZRuA/gI4i3Q8mhBdiGY/HmFlZfv51QdeMDS25fKOC1JC
	 vawtFNLQY3o237Aswrf+W3rfpM7bb8Oo01oiw2hGS+/JlbBymwbnbtfrK+8JyEaiqH
	 o7n32mh+uzQwtRuDdrIiAToeXsJQYTSw9Y5rl1vo=
Date: Thu, 22 Jan 2026 10:52:15 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Thomas Ballasi <tballasi@linux.microsoft.com>
Cc: linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
 mhiramat@kernel.org, rostedt@goodmis.org, Axel Rasmussen
 <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu
 <weixugc@google.com>, Johannes Weiner <hannes@cmpxchg.org>, David
 Hildenbrand <david@kernel.org>, Michal Hocko <mhocko@kernel.org>, Qi Zheng
 <zhengqi.arch@bytedance.com>, Shakeel Butt <shakeel.butt@linux.dev>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: Re: [PATCH v5 0/3] mm: vmscan: add PID and cgroup ID to vmscan
 tracepoints
Message-Id: <20260122105215.6648b22da4c857a3f071bac8@linux-foundation.org>
In-Reply-To: <20260122182510.2126-1-tballasi@linux.microsoft.com>
References: <20260115123809.2257-1-tballasi@linux.microsoft.com>
	<20260122182510.2126-1-tballasi@linux.microsoft.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Jan 2026 10:25:07 -0800 Thomas Ballasi <tballasi@linux.microsoft.com> wrote:

> Changes in v5:
> - Fixed a small quirk that added extra +'s at (in-irq) warnings
> 

Pleae cc the relevant maintainers on vmscan changes.  We have a
veritable army of them:

hp2:/usr/src/mm> scripts/get_maintainer.pl --no-rolestats --nogit -f mm/vmscan.c
Andrew Morton <akpm@linux-foundation.org>
Axel Rasmussen <axelrasmussen@google.com>
Yuanchu Xie <yuanchu@google.com>
Wei Xu <weixugc@google.com>
Johannes Weiner <hannes@cmpxchg.org>
David Hildenbrand <david@kernel.org>
Michal Hocko <mhocko@kernel.org>
Qi Zheng <zhengqi.arch@bytedance.com>
Shakeel Butt <shakeel.butt@linux.dev>
Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

The first patch should have your Signed-off-by:, as you were on the
delivery path.

The patchset looks sensible to me - I'll await reviewer input before
proceeding.  Thanks.


