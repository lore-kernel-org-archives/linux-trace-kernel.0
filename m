Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00F73D955C;
	Tue, 28 Jul 2026 19:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785266427; cv=none; b=CjboZ4EWo+Pd13ojooDLXw6+mm+TUQMhHnMx6aeQISXZaHY90RfQh2ik078pbTFpK771Y/WnD3tggcQoXc7XAwqhM9KVua7bQTHApB8YCRVZw5zN08A2s7nQQZNSZq8zShxzVV7hk/0ETdUlGdTjf9syRMeMYos15zDiIdzNvGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785266427; c=relaxed/simple;
	bh=soca/uuxXXi9u29kGJTwcwxy4JIFYc4gr79Mqe62rAY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=dXxiPSZDYFKiDg3ud83ZB4zuPP4eg9hyEC8hi9QhsaTTMApatajkyBJ6JZU6EHTYxbGCY2jcVwlVZrSCm82UnDrwYYyPWjtfjXCnsC7dAdxI+bGJnYodN1kE7CTVk8sZBu2acFfmSI4mI2Xrtcds120k90re/K21Yl8RUzyk+J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CVE5DmOs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CVE5DmOs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F271F000E9;
	Tue, 28 Jul 2026 19:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1785266417;
	bh=jmnt6SkHcrWhFD1fG8EVQQRclAuSqsq9ZXY40QI3bgQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CVE5DmOsX+lilJkFtFeF/hr1FfHaZt6FgvOUsBAvyQ+gcMxNyKH8lhRl5X2C2A3fO
	 cuzJ/roSOKTIg/Dp/yoFAOSCr/Zvqpo8A4YgrAyQXL0zwhRB5frv0f3aQIkU3t6Fzh
	 HBIdZgq8m2caLuMsXDQGoyAq7hDSOhrbuO+SppLQ=
Date: Tue, 28 Jul 2026 12:20:16 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Breno Leitao <leitao@debian.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 kernel-team@meta.com, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes
 <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>, Naoya Horiguchi
 <nao.horiguchi@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, "Liam R. Howlett" <liam@infradead.org>,
 lance.yang@linux.dev, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v10 6/6] selftests/mm: add hwpoison-panic destructive
 test
Message-Id: <20260728122016.30752d36c3b3c3af231efa9d@linux-foundation.org>
In-Reply-To: <amh1nZVVaaZSGD3M@gmail.com>
References: <20260630-ecc_panic-v10-0-c6ed5b62eea2@debian.org>
	<20260630-ecc_panic-v10-6-c6ed5b62eea2@debian.org>
	<ee4982bf-ff45-8f0b-3b76-7ca19228f12b@huawei.com>
	<20260727212402.09baa9381ca426273fad4719@linux-foundation.org>
	<de29c5cc-3637-cd18-354d-55ceb3d60afd@huawei.com>
	<amh1nZVVaaZSGD3M@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jul 2026 02:29:39 -0700 Breno Leitao <leitao@debian.org> wrote:

> On Tue, Jul 28, 2026 at 04:57:13PM +0800, Miaohe Lin wrote:
> > On 2026/7/28 12:24, Andrew Morton wrote:
> > > On Thu, 9 Jul 2026 11:34:05 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> > > 
> > >>> The script is intentionally NOT wired into run_vmtests.sh: every
> > >>> successful run panics the kernel, which is incompatible with the
> > >>> sequential "run each category in the same VM" model that
> > >>> run_vmtests.sh assumes.  It is also not registered as a TEST_PROGS /
> > >>> ksft_* wrapper so a default kselftest run does not opt itself into
> > >>> a panic.  The script is meant to be executed manually inside a
> > >>> disposable VM (e.g. virtme-ng), one variant per VM boot, and
> > >>> requires RUN_DESTRUCTIVE=1 in the environment as a safety net.
> > >>>
> > >>> Signed-off-by: Breno Leitao <leitao@debian.org>
> > >>
> > >> With Mike's comment addressed:
> > >>
> > >> Acked-by: Miaohe Lin <linmiaohe@huawei.com>
> > > 
> > > As I understand it, Breno would prefer not to rewrite the selftest in C
> > > at this time.  IOW, we stick with the bash version for now and add
> > > "convert this to C" to the todo list, OK?
> > 
> > Sure. Should I make this change or should we wait until Breno has time to do it?
> 
> Apologies for the delay. This is on my TODO list, and I'll prioritize it.
> 
> Just to confirm: the feature is already in mm-next without the selftest, so I
> only need to submit the C version of the test, correct?

The bash script is still there, no known issues.

We have the thing and tests are useful.  I'd say retain it until the
rewrite-in-C happens?
