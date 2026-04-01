Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA396429806;
	Wed,  1 Apr 2026 16:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775062761; cv=none; b=O1WtJTlckBrcqX04BdnDT4/QtJGtQY9Gecziq4FpChg/B3wsr1xt6dn5UbFvjAgekT8svTMXvb+mwEULOPQD8sjMTw3H5dolU8IjgXmdWmXuttKRhncRdzAwEux5m5Dt3vA2i+Nmr/Pyq9ol/Zq4aMIP5ZVqdM5ZUhHQD0CzIx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775062761; c=relaxed/simple;
	bh=iDKQEUr2/WdnWJ5pFLrhXsoNH4IvR4rVC/552eUn6m0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jX+iiNGIn4CnR7ETMrshfN6wWVRzBMe8ydC4YXp3D9JvXbUcjvxFY4G0RtSyOReBoqv2iiuyfQQh/xAEjhUrZG5zeUSSqakxApqiMlPBTeyH1Tl5R2nDLc4+rX7KDytFJUGQs1Hga47BfdZlTWAVZznjZFFcU8LtgvXhNK/BmD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 08ED01B65B5;
	Wed,  1 Apr 2026 16:59:12 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 3DEBE80009;
	Wed,  1 Apr 2026 16:59:11 +0000 (UTC)
Date: Wed, 1 Apr 2026 13:00:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing/probe: reject empty immediate strings
Message-ID: <20260401130011.4badd841@gandalf.local.home>
In-Reply-To: <20260401160315.88518-1-pengpeng@iscas.ac.cn>
References: <20260330062920.40766-1-pengpeng@iscas.ac.cn>
	<20260401160315.88518-1-pengpeng@iscas.ac.cn>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: bs4esj491qzzawkwd6h6u5wniomebzj8
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 3DEBE80009
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+K9u4mHVzDuHj7vgO2JmTI+PW87OrpMDI=
X-HE-Tag: 1775062751-917389
X-HE-Meta: U2FsdGVkX19LK+5XYWgbbXuini8JekiVuMqEO/6wp3I/F4mPos9XCLfOK5KhtFRFVFa9EM3VJzvZc4ssC9z5nS3dJRf56iy9IqtT9s6bFSt1tj8oZA0zlYNus1fTbuRHtBIwdvxNoKs8JTXVRDFxs2j3v0eqhQIwa8r2k4sN2WMJ5QCSzAFhPIshXQYCYu0caGdTFoZE5qw0XckdJst7Mz2mqsBNpxffSSnHlEbP4r36Je+ojyjzdHRTGYLbNUQieHAK2vo8IvuYSWBXB3aEAAs3QhKBLmy1b677ezGjj5kREq/vwE9YVkAG72D6Wkt3PpkGaHZwQl8C8GaO0Dx7PFD8twMVA9+5FhmWjTZ2PffmI/CU1SO63W1O383I6UM/1taTHlbVE56x2nVd+rxnUg==

On Thu,  2 Apr 2026 00:03:15 +0800
Pengpeng Hou <pengpeng@iscas.ac.cn> wrote:

> parse_probe_arg() accepts quoted immediate strings and passes the body
> after the opening quote to __parse_imm_string(). That helper currently
> computes strlen(str) and immediately dereferences str[len - 1], which
> underflows when the body is empty.
> 
> Reject empty immediate strings before checking for the closing quote.
> 
> Fixes: a42e3c4de964 ("tracing/probe: Add immediate string parameter support")
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
