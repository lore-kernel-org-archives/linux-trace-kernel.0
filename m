Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7893B25B0A2;
	Sat, 27 Jun 2026 07:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782546774; cv=none; b=Op4GGnz8fBRoDX9v4ggVr9qaimFGYg3M8FHpVXJ+8JMSgHnmeC0TzjWv97sOMKYMxPeN2W5XCMbz9mqozCislB/XdI6nhy7PJxDoIDBwtZ4AM19DW0BzkOyrWL4pQZPoKwrkxWg6CeOLa1AyRuk0TTS8b5BBjEnoZRJ0DEiDzSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782546774; c=relaxed/simple;
	bh=RVlQtCvZvvv1cGr13Nszm1cfhyX21UVNw/O9V+ZI294=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oG7gdmUTFhYeIq+xeBwNViSznbgsMbxwIOlYgwMfyk32H7sDH2oIwwT/4aToNsd2b7/BZpZbRwHfVnBvPJBUFVw7uYbX1eYVWvCMBBTk0oP1W2YXzpNC4x1BjH+DBpiOf/a9nXT9tAz6XWjPyzJdTyUG0Dj7ieBrMgEXmQij+20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eoVc6vc8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eoVc6vc8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460311F000E9;
	Sat, 27 Jun 2026 07:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782546773;
	bh=S0znFcK8j0MuvFWz2pu1AoWSdjFNtXQNpSRnuMwlEzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eoVc6vc8yM9DIkM5Wo0O2t6uxw0sx2GB1/c2P9l0zVF+KOXagAc6gIrZVyliop+Qd
	 7nfZY0dAkzYyVw8jAvnHGx5geA4y/4CXYLq06OXBuKn3reSfTXhObbuHe9gQ5ZaFuT
	 lnyo5uaI8nyu5VAEtD/9IkEBv0GcC2DfWs3wxxr/6FtTbubs4oHPPXIVELVf4K+7VY
	 WgmFy2isk/o9L4WzXu/02pEIqSp8VuH6m8O3I3FqFMTgIE1ochTNLkzHylHG1NO/Nm
	 hlANvs76XOjLm23eV7mDwVjSLPNJUEtln/VbUrO/GiOuNH50gJRqnGhSm+ufJ+CDu7
	 A0lMLVpLMK2aA==
Date: Sat, 27 Jun 2026 10:52:42 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"Liam R. Howlett" <liam@infradead.org>, lance.yang@linux.dev,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v10 6/6] selftests/mm: add hwpoison-panic destructive test
Message-ID: <aj-BShkN6BXex_ku@kernel.org>
References: <20260626-ecc_panic-v10-0-6dacb8ad024d@debian.org>
 <20260626-ecc_panic-v10-6-6dacb8ad024d@debian.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626-ecc_panic-v10-6-6dacb8ad024d@debian.org>

Hi Breno,

On Fri, Jun 26, 2026 at 08:33:20AM -0700, Breno Leitao wrote:
> Add a destructive selftest that verifies
> vm.panic_on_unrecoverable_memory_failure actually panics when a
> hwpoison error hits a kernel-owned page.

> +ksft_skip=4

...

> +ksft_print() { echo "# $*"; }
> +ksft_exit_skip() { ksft_print "$*"; exit "$ksft_skip"; }
> +ksft_exit_fail() { echo "not ok 1 $*"; exit 1; }

There is tools/testing/selftests/kselftest/ktap_helpers.sh that already
implements this :)

-- 
Sincerely yours,
Mike.
