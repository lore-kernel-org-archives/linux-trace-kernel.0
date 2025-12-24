Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6525A210F59;
	Wed, 24 Dec 2025 13:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766584623; cv=none; b=m/8cp7s2LrO19dT0bmETBRqPD94IyoGbbw8tSl2tIw82QE+FQDTg+S/XfYCWZwcmJTU/4A/rFtI+LNUNWOBICL0ehypmCmRUYBJumOLS3ESssIwjqpKmtH+ZJjNpDu8hkRG56WJ0eMyRoU19dPwAYI4O3RiZwIllA9iNgw+e9gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766584623; c=relaxed/simple;
	bh=P5j0i6s/vrGxTKQ57QoRqhQoHhV+ZYwLN2pgsxumXso=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iCzh8jay98cTYEoeX6qsqwrE3T6Bt4n0cb3dFGFkgNQC5fa3BwJksboF/ageAvROEWA6U+36iz4irKU+eOstXJrndW5GVG3j0cOsuD506gaE4HVor4VqVEWLXzUR44qMizehoQDzg8gDZyG3Gk9jxxNutOBaxSvop4543QSWZuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id CB34013A027;
	Wed, 24 Dec 2025 13:56:58 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id BDD702002C;
	Wed, 24 Dec 2025 13:56:56 +0000 (UTC)
Date: Wed, 24 Dec 2025 08:58:48 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: mhiramat@kernel.org, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, corbet@lwn.net, sean@ashe.io,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH] tracing: Add bitmask-list option for human-readable
 bitmask display
Message-ID: <20251224085848.26387f5d@gandalf.local.home>
In-Reply-To: <wgkjg2bpsyonl5qkgxgdrpmzzaduuyiti7vtifxbtdnmlrhptl@jchrtoaltfv3>
References: <20251223035622.2084081-1-atomlin@atomlin.com>
	<20251223133452.416fd539@gandalf.local.home>
	<wgkjg2bpsyonl5qkgxgdrpmzzaduuyiti7vtifxbtdnmlrhptl@jchrtoaltfv3>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: iwi3dwfdj7qdog1nrdefebtty3un17oc
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: BDD702002C
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18J1jOSJEdCnaM9i/Mt9zDui8U5+81LWA8=
X-HE-Tag: 1766584616-534642
X-HE-Meta: U2FsdGVkX19atAjIg4EP1J1pjNKeQk5DQ1h+CyVupk8LgRurxol/G3UlrH6QmVVKxZ6qnhUHjbxBHnIdM7p+jR3Lj5A2Iqr84bsvxTFVm8ODaYgmvLjtr93euim9Pf3xFSD5xvJZJRDNZGzYlk49K/86bFcyRyP48eSBnl9tyaH6ZH6tS4GXtvVE2hwCdKFtLiRqODILyuQ0xYgxI5gLpMG3w+6RQGebWuiFQ8dJWhrQlIGWb6ddaG0gBVZNj+ypn+6fMtbNGTto1feD0rl6vPQ6zhbAvLR0UMaTjYSbs14PP6HM+WlNzSVo4C2LI4oRalPmsEZjzcH+zNco1Pn7WPx8in7dpTv/6ie49GUy0AoV62jOxCZVnjg3/CwUrIcM

On Tue, 23 Dec 2025 17:14:35 -0500
Aaron Tomlin <atomlin@atomlin.com> wrote:

> When dealing with 128+ logical cores, interpreting a raw hexadecimal bitmap
> to identify targeted CPUs is mentally taxing and prone to error. For
> example, if I am investigating why CPU 6 is being interrupted, I might use
> a filter such as "cpumask & CPU{6}". Seeing the resulting output as a range
> list (e.g., 0-7) rather than a hexadecimal bitmask allows one to deduce
> almost instantly which cluster of CPUs is involved in the IPI broadcast.

Should we just make all cpu bitmask range lists instead?

-- Steve
