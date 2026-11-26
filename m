Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795658167;
	b=ifUaC1YSIl+oxoXH9ST0OL4kxc2h/KEs2My9nSp3MzTP0EP8MNc7eRsbiDvuHGsn4Pmn
	 5y7t973KfV8mxMpFRx0aTVXUvNgFeCkgWzGFrbWpxQv1yr28NZZ5rME1iDEstV/fIDwx8
	 d64svKFgI5UFNkMNLFlih83pf7M1quOvJ3MOOn0WDdshvfIK0N2gCvwj5xmgz36kbm3+Z
	 6xpJ4y/mwN9n19NIqIFsmIFuWpayBkHCYREDEh/hO5mzfVbDTrMj4NSN7j88pfaR8mxaX
	 qUaPd+tLRje7qHLY19sCVTSEzUaIGVLEjpgr1g5YAUGNGVQgw0ki+rcDYDh95kYxLTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795658167;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=pZPTyuGtPcymdp5cOv8/K4q0eDi6D2+NjC33Tash+54=;
	b=agJpZRnvKkE+rsxC8i3gCDd32o3G3mpWdusxPRmHGLuW+ATBcozA3ZbwfYZGFBjPuUsB
	 +F3PE18SdAHPKiBYTJrYsWV+O+jwQwhuVamyqkEAvY9mV4Vsw7UH+JAx57Y0XKT/CrHB6
	 zz9IfOyCdDYs2j/vQ1MDD1gwy/YdSGoV0yXMljUWl2J9g+IDCXqoXYxX62zGz6bhwfr0H
	 eoQx6lLfS1b9zhvb7U/rPGIdXQfjtpmj0XzCqVC7O31ZV1qJkfE8UxLfBkX6Mlzt8gYGp
	 HurpKCdTewGXgtgtHVQKJ/CT/4vJx5pif1qsV9w5WmHA1cgx7piQe9zOUskbkrh+Vgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=Yrv4Qefh;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9595606A31E;
	Thu, 26 Nov 2026 01:56:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9595606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=Yrv4Qefh
Received: from omf17.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 7648D8022B;
	Thu, 26 Nov 2026 01:56:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id 9DAD118;
	Thu, 26 Nov 2026 01:56:03 +0000 (UTC)
Date: Wed, 25 Nov 2026 20:56:02 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 11/15] tracing/filters: Fix error positions in filter
 parser
Message-ID: <20261125205602.3699ba86@robin>
In-Reply-To: <179323794702.740114.679129900715570251.stgit@devnote2>
References: <179323784538.740114.15323117974242744566.stgit@devnote2>
	<179323794702.740114.679129900715570251.stgit@devnote2>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
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
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 9DAD118
X-Stat-Signature: hdrjttignmasxxc78qwozdd7ujw6rd95
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+n0Et0sJQWjj8uDsd+6itv3npsQbrPhL4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=pZPTyuGtPcymdp5cOv8/K4q0eDi6D2+NjC33Tash+54=; b=Yrv4QefhCEf9qsNXK0H1PFo8uR18ZZEd87tdkT15Gq/vhSn9UzAh9ZZ3Fk4gmwOC8VAs1Sp9IkvEm3zfiC2iHzwk9r3j+/eET7qOADz6W6XcbGirskbF7sBHMV/ibglOb9L5yxsM9hrzuzJzWlHI1mtaQ4WCeaRhbq5I1jhjowY=
X-HE-Tag: 1795658163-212433
X-HE-Meta: U2FsdGVkX18c7wOS5QWggqhBSdzchK084Ya7bZrEo8TW1picEUt2stpWuBUsOY9E8oG5huD35d1Rcbn9oHbwk3RxSZgpF7RCMb03ekZ/n/xk5vLJN4cSGYC6t7qn/tMYqNnK6l+AeBiY3pH7jTpT+eBG39q6gu0c9AOpR32VItsuMNBcc197abEdxfrIDsShC5TZhmhsLTct/RuQDlFPz0pwuNhrIarBrHc69RlUWlD5KKinu/DS5klZSnTNfHU2diQfepwyaAkGrHr5jmVG7uxLdEksyEH8r3xJg6kt5nHRm0NLiacvMAQRLsqr7R8o1XWCZyfA0E4SZGmBo3FsdlcoxDV890Pay3wFXe/ssv9f3RBAcTLEJ5UL1xJflHF3

On Thu, 29 Oct 2026 10:39:07 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/tracing-error-log.tc b/tools/testing/selftests/ftrace/test.d/ftrace/tracing-error-log.tc
> index 6c190620db47..2c900873ce3c 100644
> --- a/tools/testing/selftests/ftrace/test.d/ftrace/tracing-error-log.tc
> +++ b/tools/testing/selftests/ftrace/test.d/ftrace/tracing-error-log.tc
> @@ -10,6 +10,6 @@ fail() { #msg
>      exit_fail
>  }
>  
> -ftrace_errlog_check 'event filter parse error' '((sig >= 10 && sig < 15) || dsig ^== 17) && comm != bash' 'events/signal/signal_generate/filter'
> +ftrace_errlog_check 'event filter parse error' '((sig >= 10 && sig < 15) || ^dsig == 17) && comm != bash' 'events/signal/signal_generate/filter'
>  
>  exit 0

This causes older kernels to fail.

Is there a way to have it check both?

-- Steve
