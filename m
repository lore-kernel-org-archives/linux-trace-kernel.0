Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FB73EBF21;
	Wed, 11 Feb 2026 15:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770824805; cv=none; b=uuybO5ryuWO0QPPJbiE7ht9nQz3dXjsvOduRoUh+YrgRTORDBMOP3e5HkLV7eGV4XRghirnWr7ybAzCasKpfNlSw7DXQmXqlvZV7bu9Iy9XwOAU2q+3PHq7cMuQcEG2acDIjhvqPx9qD0K+lcIB+lS+3G1LaLC/WHQwCdZWMHCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770824805; c=relaxed/simple;
	bh=dKESkE1M6rTLiT+PlXRL45TY8rMKra3nAeIwKvBJzGA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lj4NoAoOXLfuF/0uyepsnNfIQKNfzm3LGjb/+QX0Jm+msgt7grJBEmgybRDLwaU/zdaGrFNibS0LNQGNcC8iqvB2/PJAqV85PRVmPVA6uXdNnPH8nyH8cQM2bSDAb9sknrVto419h+lt58t4daOvIGyuBhRJfba+atOZRN7eL7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 4A48DB8C1F;
	Wed, 11 Feb 2026 15:46:43 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id B773F6000C;
	Wed, 11 Feb 2026 15:46:36 +0000 (UTC)
Date: Wed, 11 Feb 2026 10:46:23 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v8 3/6] tracefs: Check file permission even if user has
 CAP_DAC_OVERRIDE
Message-ID: <20260211104623.73fd4fc3@fedora>
In-Reply-To: <177071303130.2293046.2400906233143699263.stgit@mhiramat.tok.corp.google.com>
References: <177071300558.2293046.12057922262682243630.stgit@mhiramat.tok.corp.google.com>
	<177071303130.2293046.2400906233143699263.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B773F6000C
X-Stat-Signature: tp51wtqoxeoo1wye4kw1js676ksnr1oa
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX194WRGCmGXHtynF2kmfJfYlAVog6Zt/4vw=
X-HE-Tag: 1770824796-744664
X-HE-Meta: U2FsdGVkX19VB/dUNqghVOMwDR4Th4JS8KacZ6ihidFrfOHHv0ylsrxRAfViwblzxrRco20tLSdMrEanIEbnjEk9F1kGhzRyFL0jzwRYYupu2DA8zyMYnljOEwOxK+/QruirJ4z92okuMGKUthqmWGx+dN8uzHevKIy1yn06Ycb9c07nrtmavbPbUoCGRmijUIr3xqL99FhUUecOaVlz2PG3cPtxvav7fApm6d3Sj0JJrbvBGlhZYOygTZPMB+SNzgveB45I0M55Vx7+Q5uE+eRIiIUxD3m8ygXPcdPFdBQGRIeXFaDC39IRoi2+rkpx4R1dfhWTK2tIh7dHjaj6paG0jjkvQBnpBjAwM9o9QaI+uOysNfoNeg==

On Tue, 10 Feb 2026 17:43:51 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Strictly checking the file read/write permission even if the owner has
> CAP_DAC_OVERRIDE on tracefs as same as sysfs.
> Tracefs is a pseudo filesystem, just like sysfs, so any file that the
> system defines as unwritable should actually be unwritable by anyone.

This is getting too complex and still doesn't work. As I said in my
other email, simply check for the trace_array being readonly on opens()
and return -EACCES if it is and was opened for write or read-write.

With this still not working this late in the game, it will need to wait
until the next merge window. I'll take the first two patches of this
series now though.

-- Steve
