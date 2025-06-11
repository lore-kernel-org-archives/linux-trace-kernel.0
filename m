Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE901224882;
	Wed, 11 Jun 2025 17:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749663428; cv=none; b=EXKXbXtJ6ZWLIIsh2aAiqFYHEJX0IYRR2Lv8Zb8+WHSLUo1zAYMrPJ4uCihfIKFePC5vbnDpAOg4NZPYMVU8cP2Jj4DsW9+l3llMy76DzmJgZQKimGigHwV83m1Kktem2CKmSROEQfBheiQv4iA7Ut1A9TRBK6ppyxIGlOURn0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749663428; c=relaxed/simple;
	bh=VMUK+sl62s49iLfhRzSxD6TI8pQfklv8QpNaE41TV8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V47V1NR6WRQaSrNnLl1e/E2gX74oFud6WRLQbdTt9e5A4go/1Ect8uePgmsFNc49frdpVLUpNLk2onFlojKg0hdeOp2DeL5Nm5ofQy68BBlcmlv9tDAEGQdXtKHSaxeFRhYzPZsH3YzQr/uktbS5Z9c5gAn7PxTS/agU2UFLs2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=bwyDYSS9; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="bwyDYSS9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DepT5as+DqmaE8TroehmPFoCKfqX6foaMLzj8OpaDos=; b=bwyDYSS93gc++nsYCHxly65fnW
	nDxDEFZNtZCKv1y0IAN2AOsCVMQmawKL6P8m79dXeAM1ZuDugxKqqbO3gmShFjQLlR7YCYQq3eGof
	P5AO0Mx8aEXf01KgKn5vVTHFSx+C7EAZbITy94RWpISKuefAh78XJht/RuzD00QD5Vd+FKwpsgopJ
	f/dFcK42+FI76TtMOfD3Wt0r77Y6PZRRoJJbgRxtZIRVo2Hr7bjPcr/HKI+F3PfuhdAJrEGOO2TNb
	0M34u1JiDfIQmUUiq6zqoavLu31LacABnGvgxw6zaYJ+rr7fMXNXAZZV24MDWxmIk/GuThsuKucQz
	alZMcnAg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPPNm-00000004hS9-2CLe;
	Wed, 11 Jun 2025 17:37:02 +0000
Date: Wed, 11 Jun 2025 18:37:02 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracefs: Add d_delete to remove negative dentries
Message-ID: <20250611173702.GL299672@ZenIV>
References: <20250611121815.409d02f8@batman.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611121815.409d02f8@batman.local.home>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Jun 11, 2025 at 12:18:15PM -0400, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> If a lookup in tracefs is done on a file that does not exist, it leaves a
> dentry hanging around until memory pressure removes it. But eventfs
> dentries should hang around as when their ref count goes to zero, it
> requires more work to recreate it. For the rest of the tracefs dentries,
> they hang around as their dentry is used as a descriptor for the tracing
> system. But if a file lookup happens for a file in tracefs that does not
> exist, it should be deleted.
> 
> Add a .d_delete callback that checks if dentry->fsdata is set or not. Only
> eventfs dentries set fsdata so if it has content it should not be deleted
> and should hang around in the cache.
> 
> Reported-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Applied to #work.dcache
