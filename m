Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55442F6922;
	Thu,  5 Feb 2026 17:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770313643; cv=none; b=n877qBpo75ZmpoAg9xrxnlGEQSS5PwfIcKXofPLNVhqtIDK1SCzKrLmo8AbVxjQ1n4JkhqrPp4PbcUSzYx8iMmuvVkkKO8bcdB9jth89+LYnu/uKIWZEYwZuGxYi+vVgR4aTzbRhh39HvJUTDnGCDHa2CIMTNcIQCBCugw72nzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770313643; c=relaxed/simple;
	bh=2QBDGk47Cm9aXe39IgLOAfT+OG+qo0OyaDGY4NGNgiU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m2EGWgH32dotYPcgOTHVcVnJXKF2ZFSkh5AdxVDvBwgYIl1HNbj6fvjbnpBIyPe8TS6c+GxU8WX6iyYMcIxwSSzfRTSqV/9536uV734hEu9yhZLAlqpez2JKyihihWrPQaR8lAvprTgEEP5LqT63ViIiteTEytVDvDvLbjEaoxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 02A9AC22AF;
	Thu,  5 Feb 2026 17:47:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 78ACD2002C;
	Thu,  5 Feb 2026 17:47:12 +0000 (UTC)
Date: Thu, 5 Feb 2026 12:47:47 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev,
 joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
 kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 jstultz@google.com, qperret@google.com, will@kernel.org,
 aneesh.kumar@kernel.org, kernel-team@android.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 17/30] tracing: load/unload page callbacks for
 simple_ring_buffer
Message-ID: <20260205124747.2d20e7dd@gandalf.local.home>
In-Reply-To: <20260131132848.254084-18-vdonnefort@google.com>
References: <20260131132848.254084-1-vdonnefort@google.com>
	<20260131132848.254084-18-vdonnefort@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 78ACD2002C
X-Stat-Signature: hcgabi74er6wow3x8o97pjfpgrkmg37b
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18+scA38KKadGgltS/q7U1r26QpHyVI9KQ=
X-HE-Tag: 1770313632-94438
X-HE-Meta: U2FsdGVkX1+D59E1RF9ThltX/RloR0giazvzIv/7B7wQmgBGSkXaUl/ZuPCQOuOIKOI+wzY9JWfvFh7G9CWgqY7vQDV9YHmkUdqOEh4iQqUa5yCGrLqmHQg/FMxyK5B4pzRA95fQMVkpP0kRtIdVBv+1dS7pkGiykDUMw4HpH0XRx2w2U9HlBr7Pct9V/8j4XGNgBkp6yTSKncEj7ZjIPCOkZhpQlfnS5Wkr771qh1QYb/a1Z/FvyQRTT6RW4VSptVyRHbDExfvKgxbQM/caL049dLajA7zBAbmpGc0jXFXUvUxqp/3yiU88cAyl1N1ezQkMki5EN/jpAGQJPmumccScBsqUD98P5DvDhTkQFe/CDt4I/CxutWKNmucMZ9T2aJqWc/7JvRKanRo6ZTza2g==

On Sat, 31 Jan 2026 13:28:35 +0000
Vincent Donnefort <vdonnefort@google.com> wrote:

> Add load/unload callback used for each admitted page in the ring-buffer.
> This will be later useful for the pKVM hypervisor which uses a different
> VA space and need to dynamically map/unmap the ring-buffer pages.
> 
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
