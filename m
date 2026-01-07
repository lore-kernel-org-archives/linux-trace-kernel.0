Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E543339875
	for <linux-trace-kernel@vger.kernel.org>; Wed,  7 Jan 2026 18:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767810732; cv=none; b=rpkdc3DCVaaaS6MpgpTnGo9QvjPUF03OJ2jkklmNOwq/Ub/9LUiByi5mzQmVlYvt0iGE9cmQTL/UmBCK8F0s8BjgK/sCxPlmovyKCV8+D255tyVk32MQic4sJU4f8vfAcVcPMNvjPwNUnDccTJmPNqCxrSrHQ1QX+drnr9dQ+XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767810732; c=relaxed/simple;
	bh=7ICgTImWvYWCenkI2+hXNPLSdjtpu4hBw3mxjXZeAlk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WzTuam76BL+Z9ORgVG8zX2kN5Mw7Smdwo1EKklTs64apPkmgq9+Nh9iq2XuCEFE6uLwLDYzdmn8fRuMNNzUiFgkGH+qLXswkndOixYHIeu8oIHK7eNObHqIk3S+cr7AnJ1KDBlk/zMTMk2L0/eSEnUcY0ECo9kpqLPtcJn165lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=jjTWHxQh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="jjTWHxQh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73219C4CEF1;
	Wed,  7 Jan 2026 18:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1767810729;
	bh=7ICgTImWvYWCenkI2+hXNPLSdjtpu4hBw3mxjXZeAlk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jjTWHxQhmiDt6mFITXMLh7G4TTTr7lD6lgQzc33gGccDRZD7o7luipSPDYygxWlr1
	 DEkgWhhcWVA4LxZE50vb4udhBsjJV5C609p8TMYa1XrqnK/1DJPTA1gQFMEGikO5hi
	 ricr2Vpg6Ve2FrP/lw4dDsSQYDfMdIbvfZBWwRKs=
Date: Wed, 7 Jan 2026 10:32:08 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Thomas Ballasi <tballasi@linux.microsoft.com>, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
 rostedt@goodmis.org
Subject: Re: [PATCH v3 1/2] mm: vmscan: add cgroup IDs to vmscan tracepoints
Message-Id: <20260107103208.e64fe3c26d02bfcb21404dd9@linux-foundation.org>
In-Reply-To: <ovqxo2mmjiuymqk36t2xydcyzvtppcqsog62yx3qtwsknbkgzq@3phadh5gfyjd>
References: <20251216140252.11864-1-tballasi@linux.microsoft.com>
	<20260105160423.23708-1-tballasi@linux.microsoft.com>
	<20260105160423.23708-2-tballasi@linux.microsoft.com>
	<62ia3v3oduyt2srkaneccoei7cwimifwduarteyn2ugpmmbw3p@rivcqvcksgpt>
	<ovqxo2mmjiuymqk36t2xydcyzvtppcqsog62yx3qtwsknbkgzq@3phadh5gfyjd>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Jan 2026 10:14:53 -0800 Shakeel Butt <shakeel.butt@linux.dev> wrote:

> On Mon, Jan 05, 2026 at 02:46:39PM -0800, Shakeel Butt wrote:
> [...]
> > 
> > Orthogonally I am cleaning up memcg id usage and after that cleanup,
> > mem_cgroup_id() would be preferred way to get the ID. No need to do
> > anything now as I will cleanup this usage later as well.
> 
> The series has been landed in mm-new. Please use mem_cgroup_id() instead
> of cgroup_id(memcg->css.cgroup).

fyi, I removed this series yesterday due to a CONFIG_MEMCG=n build failure.
