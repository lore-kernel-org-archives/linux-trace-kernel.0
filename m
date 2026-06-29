Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD3743C065;
	Mon, 29 Jun 2026 15:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782748297; cv=none; b=agSu0zYrWKX6N+EusJq92XdDyEVrgjbJKmVQKAW6+isTSciFBLidYJWt+nov2gI906hPaLoelmoFRGeuQund7ReqQul5GU/pEqKxDvxacymZSiC0ulHc33ZV8VEDfXDYZmNxUDGIsG7Lv6yfBrpIRJQIgCyUvRpPLNLhBxdAvTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782748297; c=relaxed/simple;
	bh=Jfpbh1KLhwtXc+BxstE95MlO6t2jjL+Fd0+Ww72x8xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSBjdfpWEqKzppjZw+4+zXzs4QvcSRrhq9FRMGTtwZ/Ykt1+1BZ1+tOViKjtxN5Xbauq9czSs60h6M9SFgCyYtHVfc036FhieGPr9/7hWe1gy1/OvKgyBgsgpYv7FWTx3Voaje0RNf5HPj4nP+wktdGK85QW8KNgwxNwRneCnS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=mqqMcK/S; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="mqqMcK/S"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VeejG0MGjUvD4AhkLMN95MQ3Dsdsxp52TnuJQNelYwA=; b=mqqMcK/S0ffTfirKJEMqcC/Ija
	8MScC4GpriSuke5cvw9W89OocMlePAkwIX6hRqRBAOBICl/Jk24xJEReCepneIo9AsQ6T64BsTEuU
	KJ7v6x86URFpLL6v0b35ayfP3ksScr/ZCwY+9RFl7FSivLEKwP1HPvd4T3Ky0pLFbp0Emy+LGVbAT
	pa+V0JFJJnN0R/VjabN8iyidZewJxzgorjpeRhG+v4WZV/eUD+Er5X0mQ+KbBMLPuVhOWukCRRPkg
	UOfYtf/pIAn+/y4sWQEsSlib+rJMDZxTPoWNtksRVS/9IjviHEnjRXOIgnK+lHrm7PpeaF8mwBgHD
	xA9VFsaQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1weEGA-006Ojz-0e;
	Mon, 29 Jun 2026 15:50:58 +0000
Date: Mon, 29 Jun 2026 08:50:51 -0700
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
Message-ID: <akKUDDtww19NVra4@gmail.com>
References: <20260626-ecc_panic-v10-0-6dacb8ad024d@debian.org>
 <20260626-ecc_panic-v10-6-6dacb8ad024d@debian.org>
 <aj-BShkN6BXex_ku@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aj-BShkN6BXex_ku@kernel.org>
X-Debian-User: leitao

On Sat, Jun 27, 2026 at 10:52:42AM +0300, Mike Rapoport wrote:
> Hi Breno,
> 
> On Fri, Jun 26, 2026 at 08:33:20AM -0700, Breno Leitao wrote:
> > Add a destructive selftest that verifies
> > vm.panic_on_unrecoverable_memory_failure actually panics when a
> > hwpoison error hits a kernel-owned page.
> 
> > +ksft_skip=4
> 
> ...
> 
> > +ksft_print() { echo "# $*"; }
> > +ksft_exit_skip() { ksft_print "$*"; exit "$ksft_skip"; }
> > +ksft_exit_fail() { echo "not ok 1 $*"; exit 1; }
> 
> There is tools/testing/selftests/kselftest/ktap_helpers.sh that already
> implements this :)

Ack, let me source that file in my selftest.

	DIR="$(dirname "$(readlink -f "$0")")"
	source "${DIR}"/../kselftest/ktap_helpers.sh

I will update, thanks for the review,
--breno
