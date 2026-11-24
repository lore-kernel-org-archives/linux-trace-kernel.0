Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795529918;
	b=UQgDE9dFOllyrmbXvVlADPVS/KOqnmkWLw/LW5KDMdBJWwdJ5Gjdlc3bn0ralmCGUkds
	 QT3XbXwkVrISSG/9VuKeNb2prXhKMME1oQ8IDI7mjkfDzJD/gS37EiAJmlVW6qxLujrEx
	 +2I+t78WUSeqnJNyeHqugO85w0S1WIu7LAsdniLTYlAV8NkVGoyBkkR+/hjSw907A4iZ1
	 YB5QT+gJElm9XSHKe1CdTr1tcwKwllqxuBuXckhE7MbCEwjWqNm32A16qAyICaDbGlGKn
	 Ohk5PZ6Q4RYAoE06175M7HLU9pbD9vhS2FNFqH5BmiNQC8Ej9/SeF5wdgVziWNG4osg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795529918;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=j4MD4Ah8YVfNeDDVCjOQWnQCh8tQKZ8jPvBbtYFrC2A=;
	b=zSXppkKxxAtHjavqRJbFjsBlCm6iTsrhdjE7a4jEo2dE2PFovVQccahjDD+9Tm2NhUAN
	 qJpgmowWuYKMzN8ccDP2azpH+fVs96Wy4ISXLQRBWFZGAKGf1y1lwWOhUHl62HU1jGkoZ
	 gIpsEVmAnQqlgLVcGttd6LnP5TeYkrwcvOMMKPrrWP1/4C66aAFDMMgUcMATdFCyQ6cOD
	 cGKRM3d1GReoLmPTkB2G2I7Bz+amn6CUc+xGz2h3di6gmXv8wnM/TlLH3xH/rFA3MurA8
	 tqidEJHw5ZAK3gXnAbRz1JOkZLHKX51aZwdApZPjblSFGNWFVZeozGB/p8+Yad/9cuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=TiIRqxq2;
	arc=none smtp.remote-ip=216.40.44.17
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE349606A31E;
	Tue, 24 Nov 2026 14:18:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE349606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=TiIRqxq2
Received: from omf17.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 56E88A89FB;
	Tue, 24 Nov 2026 14:18:36 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id 6898317;
	Tue, 24 Nov 2026 14:18:34 +0000 (UTC)
Date: Tue, 24 Nov 2026 09:18:33 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/ftrace: Remove non-existent
 CONFIG_RESERVE_MEM from config
Message-ID: <20261124091833.3c3d705d@gandalf.local.home>
In-Reply-To: <179547315291.329986.16935545207857031949.stgit@devnote2>
References: <179547315291.329986.16935545207857031949.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 57yfqmaectf9nthzreb4bwrxzbkhcdgs
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 6898317
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19tPeY4sSVYsy4SHWH1zIl8k4NGYvLi1ew=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=j4MD4Ah8YVfNeDDVCjOQWnQCh8tQKZ8jPvBbtYFrC2A=; b=TiIRqxq2bngPzHkOg1Ol1s5L5NpnWs9XkcIp+QefHs862Xi3cVe2Qk1bMC9uRDxR86tP7PCzyIUnV3/UhORtC0PWlaCtoAnPUXkGxwUAZG+eDn6JTVb7Xqx9/C8/9ujqGr5hLxfJuZ4fFf8GsmK11wo07yiqEBjGZJIddWTCoT0=
X-HE-Tag: 1795529914-377196
X-HE-Meta: U2FsdGVkX18DQdcH3lpsWSDC/pyEUlJBHSstbYMpk5TCkIlzLRuTD43FJK8OJraILqs2Bo6LjvRrQ1PY3G9SBLCfQGKmZqCLGYHnO/Gmos8BoXtGce2mnqhlJDkc+/jVDfzCSiFk/zvjh5nhJb7kx9VAsmakBc0V6vL0nr6N6P5113FvSSUy4T0QrCqwAhNlThEfA75ZATnNVWl0QTwO+kQ9FD8mW1ujwuWx8Pb/zGdW80tyjz8+1NIeU/pwuJ62oCx74UH/Scs3ucCgB330pWx+Ty1rdJt6zb9qKFIbJAubkcv9zf+mK4ElDKDGWzfEDd2MaIpD0yPg65jLepMOEKVwVJnc+A70ZlDA9QwVx0AZPiw887sVZXvPDBnIgOVZBYwp71vb40nlq2B6S96xBQ==

On Tue, 24 Nov 2026 07:32:32 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu <mhiramat@kernel.org>
> 
> CONFIG_RESERVE_MEM does NEVER exist in Kconfig. The reserve_mem= boot
> parameter and reserve_mem_find_by_name() are built unconditionally in
> mm/memblock.c, and persistent ring buffer instances via trace_instance=
> do not require a separate Kconfig option either.
> 
> Remove the non-existent CONFIG_RESERVE_MEM=y entry from the ftrace
> selftest config fragment and the boottime test README.
> 
> Fixes: e666e6528359 ("selftests/ftrace: Add generic boot tracing test framework")
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Reviewed-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve
