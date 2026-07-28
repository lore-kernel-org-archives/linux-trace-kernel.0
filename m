Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495FC3876A7;
	Tue, 28 Jul 2026 04:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785212646; cv=none; b=T5MT1C4zkUzwvXYnBhXXzCN42STW/AhOx3K6GwOw4wK/ZJC37RNOPiyTaLz2GTekF6O+uUVIAdXiPnuwh9v208TfB0VzJmkQNmT7ZSgmKUhCnLbAwjJkEbKvZGXssYXiZir6WPbol2fu9tzbmWQfCGSJrLBj/mpoUZ+VTt1/Q0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785212646; c=relaxed/simple;
	bh=TV0vn7xOGi/mH1KF8ZmxRN+1ZS3uwizd+ITrgJfAvzQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Hfa3dGgTu5rtkkrkZL988wolI+t81r+nu8c4BMtrT6aAdIUNhq6TX8PQPnNNi471nxZeOKXlEqk1PwGX/vhXToNdQA9lvOonbCu0PHps4HzjmchS+sj48of3/7H0axY1ddNqYHO3lu5AK58VarCoLQ/0yyNAsdBj+u44v+QKIXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Zk6eLt81; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Zk6eLt81"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD47B1F000E9;
	Tue, 28 Jul 2026 04:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1785212643;
	bh=PQyIhBnDSp1LeV5j63D6Dt0ddnF6P/tt+RnNOupEkLI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Zk6eLt81z8NT0gqcdR0ASwDusUAygxVuTdX3+9SkcYZjzBv6w/o0AK0w754iNu4Sc
	 HybK6J4Th2iMENNUY3oEniHIGPeaxNSWE3hFyyIyRFaXokBHx0td3W28F7xOm6Svwm
	 5bdIAtZ0o95LWV/SBC5RR8k0twaZwbGmQNQNgSHk=
Date: Mon, 27 Jul 2026 21:24:02 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: Breno Leitao <leitao@debian.org>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <kernel-team@meta.com>, David Hildenbrand <david@kernel.org>,
 "Lorenzo Stoakes" <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>, Naoya
 Horiguchi <nao.horiguchi@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, "Liam R. Howlett"
 <liam@infradead.org>, <lance.yang@linux.dev>, Steven Rostedt
 <rostedt@goodmis.org>, "Masami Hiramatsu" <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v10 6/6] selftests/mm: add hwpoison-panic destructive
 test
Message-Id: <20260727212402.09baa9381ca426273fad4719@linux-foundation.org>
In-Reply-To: <ee4982bf-ff45-8f0b-3b76-7ca19228f12b@huawei.com>
References: <20260630-ecc_panic-v10-0-c6ed5b62eea2@debian.org>
	<20260630-ecc_panic-v10-6-c6ed5b62eea2@debian.org>
	<ee4982bf-ff45-8f0b-3b76-7ca19228f12b@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 9 Jul 2026 11:34:05 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> > The script is intentionally NOT wired into run_vmtests.sh: every
> > successful run panics the kernel, which is incompatible with the
> > sequential "run each category in the same VM" model that
> > run_vmtests.sh assumes.  It is also not registered as a TEST_PROGS /
> > ksft_* wrapper so a default kselftest run does not opt itself into
> > a panic.  The script is meant to be executed manually inside a
> > disposable VM (e.g. virtme-ng), one variant per VM boot, and
> > requires RUN_DESTRUCTIVE=1 in the environment as a safety net.
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> With Mike's comment addressed:
> 
> Acked-by: Miaohe Lin <linmiaohe@huawei.com>

As I understand it, Breno would prefer not to rewrite the selftest in C
at this time.  IOW, we stick with the bash version for now and add
"convert this to C" to the todo list, OK?

