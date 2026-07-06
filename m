Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE3140683F;
	Mon,  6 Jul 2026 16:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783354497; cv=none; b=jYa2Zhgl1EuYC8QMVzt2jgWNYCj5z1Th8dstBQ8wyVqolqJorEXFFFLBK677FenIY+wlltNhWMrHSJ3g9hNYVBHUk6nTZ9dTOpAUwHIDlqcITFRpsCjdJYxVO+zcYu88vunRg30yFeED3EdJ4QI72DrKMOxQejjzUgoMQqTbJIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783354497; c=relaxed/simple;
	bh=nxCleHpg40spjwZm+IaFSsyRCcoBS6IkMmrXC6FGTxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHTXNiYjlPLdCg5GbG8sZXgOWBhI0wNSrUNQvzKwA99TKJ2BQVcUPVrGaxfOOCM3VuXsjkIRgF0qBQaZDJ8bFlJZLbXXSf2qNiTXhkhw1fF+BVfyDX0bs70ZG/zS+qfhqYBZLf4vqwZlwHt9G8yfB1qLWGMXqq2rwriPw0EWxBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Ydnz4US+; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Ydnz4US+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lE8+oP1XZjjpdBFy2VrkSZhpJog2DvPRMczl++eRN6E=; b=Ydnz4US+QFx44rkGq3ArU7qxzv
	+zU4oxFKJ09GE4PHFj+Q7ERLs/y0AJITwakgtn3r7lBg9lPuOJ6TgshWCI+IFhcEjuzuCYT72PMDE
	6lXkL4ukw9/nrvU4QLyJrOX9tHh7IkKAjh27GBOkcvnAxUkFRYOuEWDw8sOv08J74Z+RAcTVbFMkv
	pfyYfE6rAhDMgHjxAIlwn/IJSSru4PSVUgX8Mg4+/X8Db5dBBuUWjqVjR9JDNZVcizNe7T7CPpjlc
	aFE0Qc/z8mQW0dJ34QzI2wyOJyDTVFwzHgwhU1TkFE/m8uqD1mjZFDpeqB7dfqWIZf0YmkFJSCs1/
	GWFRwxZQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wglxl-001Xdp-0U;
	Mon, 06 Jul 2026 16:14:29 +0000
Date: Mon, 6 Jul 2026 09:14:22 -0700
From: Breno Leitao <leitao@debian.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, "Liam R. Howlett" <liam@infradead.org>, lance.yang@linux.dev, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v10 6/6] selftests/mm: add hwpoison-panic destructive test
Message-ID: <akvSzb0mRSS5aCg_@gmail.com>
References: <20260630-ecc_panic-v10-0-c6ed5b62eea2@debian.org>
 <20260630-ecc_panic-v10-6-c6ed5b62eea2@debian.org>
 <akjS7kiGjVwWaWEz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akjS7kiGjVwWaWEz@kernel.org>
X-Debian-User: leitao

Hello Mike,

On Sat, Jul 04, 2026 at 12:31:26PM +0300, Mike Rapoport wrote:
> On Tue, Jun 30, 2026 at 05:46:09AM -0700, Breno Leitao wrote:

> I'm looking at these awk scripts and od encodings and I wonder if wasn't it
> simpler to write the test in C.
> 
> We have a bunch of helpers in tools/testing/selftests/mm/vm_utils.h for
> accessing /proc files and there is already /proc/iomem parser in
> tools/testing/selftests/mm/pfnmap.c that also could be lifter to vm_util

I'm fine with either approach.

My main concern is keeping the selftest decoupled from the feature
itself, so that review of the test doesn't block the feature from
landing. Would that work for you?

Thanks
--breno
