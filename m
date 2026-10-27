Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793105120;
	b=QU9LOZ0ML1Ap04AFFYjJg2biV9CBZEnUryx0yAwbJpCx1hxDb2S5jluVPqEbtivsqxJQ
	 zX2cZWfMGA+ob9jSPE5K3wAa4xcdRbB05+cfakVNFRT64iUNpz/+v5CZ1odYYOy8JAmv0
	 BkBTZ+RhUTmRyqEUxQtpqC4jYeymXPGGLVHcx8P4eQezghfOW6i4nQWfe0exWgHFlfmAj
	 QprAAsT8xSFV4OdPmM1rQ380aetlLRa9IDTVtnlcSJUsYZmpjNSX33iWyyBRDQDUkdk76
	 Z62ZfTioKOjlsKWvXpYqreYEW2wVsPMVtgfzliLUTXuYRdHW/0lh7DrMPHXAvLEBzZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793105120;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=cp5F5plX1o9uNVRyUnVlyzWtsNabM89/L+nyYHXZXX8=;
	b=EhfuI1OSGf74KevBak/85hVDVwbRRVBCjAtufXfK9llFid1tIQcxHXD8nAxG3bB+FcoQ
	 Rrl574lOmVwMQxtOOPdGMgm0Og9oftTOvIp0IS+/brj+y/7CFyjeYa2do3O9POvmrVTBZ
	 jQmY6zGHHQguKjjqimth3NqeJhG0/ImQqKkBbjjGSAkBl/HY3jY0hjHGrjqbUpRTEV95E
	 9jTqYyK9SwKV4CQNmnUTQscgS8N1dc/Nrm8r1UrwL/wwQU+JTEkK3BuSorBlhKslR5K48
	 F9EPHjqu7KEVJZ2yB1OT4q9Afyhs50DicMtTXu5TLzSFFGHHaHFW32qYSydGgRCsUlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=Q9pYh5eX;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529BD606A330;
	Tue, 27 Oct 2026 12:45:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 529BD606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=Q9pYh5eX
Received: from omf05.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 03BCB1C3F4F;
	Tue, 27 Oct 2026 12:45:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 1F84E20018;
	Tue, 27 Oct 2026 12:45:15 +0000 (UTC)
Date: Tue, 27 Oct 2026 08:45:13 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 6/9] tracing/filters: Skip second character of '&&'
 and '||' in calc_stack()
Message-ID: <20261027084513.16dcb663@gandalf.local.home>
In-Reply-To: <undine-1793059963392038141-496f89524ad52c64@undined.local>
References: <179291742944.492959.11659339795290028998.stgit@devnote2>
	<179291748555.492959.3275503783612449972.stgit@devnote2>
	<20261026164727.0d1636cb@gandalf.local.home>
	<undine-1793058642821980546-e873f302f6a6d563@undined.local>
	<undine-1793059963392038141-496f89524ad52c64@undined.local>
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
X-Stat-Signature: whotn9q6szo35b7buf4zhw3e6c6kk6is
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 1F84E20018
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+zguBbqu5krc6CbB7lx/helQypDPpL6/o=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=cp5F5plX1o9uNVRyUnVlyzWtsNabM89/L+nyYHXZXX8=; b=Q9pYh5eXyKKG3lpi69ZRFB7U6Oi+Qe1mPKkgGR4SRLc0tBzDQesXRZ/Gllo8DgkqN6Q33qoWaS51imiTYdmcdIb2U42pj+WJH+t5qYABWVz0XvYfE/oCWsi6i3X4i/TcKTkFO+hDd/vmboDs/Q+CWqHMh9qzD1HCI9o1DRUbdLI=
X-HE-Tag: 1793105115-725216
X-HE-Meta: U2FsdGVkX1/Td6Ojvo70Dsv0u/cRljFIAxmwzShFO+L7SxtpEthVgsRY+yTpTFkxKgocBQZ7yXh2flLfdwZWRexMCZgTAH5yCYRXDkUtMlxsGmpM64LVXdnQ1ljKYQTxQoSrHbzlMdZDtbAYnFB1RGhb14RU3Kc0YvrxCBJpWw8k5a3GBoAWb2/pbMDPktbihTNJvwXGpc6L81QHoQbEZruQad3e99I/7bYRklF8p2PQQTWppziz7u8jzb294rw3NAvh4esWlkra3bN2TzXjW62mywMgKrSP7BNpj2RpyaX7CVcUiigcjDgzfjwR2oAElS5WCOA3ex1nUal42HH79Aq7aOizuWY7

On Tue, 27 Oct 2026 09:12:43 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> BTW, to check the correct input is encoded correctly, we may need
> in kernel selftest or a feature to dump the interpreted pred after
> "#" line via filter file. Latter one allows us to test it via tracefs
> (ftracetest).

Hmm, I guess we can update the filter file, although I'm a bit nervous
about backward compatibility.

IIRC, the libtracefs does self tests and clears filters. That may be a way
to see if it breaks user space.

-- Steve
