Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795122166;
	b=ULm8OUO06bUFbGomHT99TCqUWQDe835Nay0ZT/IRMXQ1svyhY0ejoijaYk9fvB2L6bxy
	 PhkHp/reJ5GCxxZqyYN2YJCQVYPLCNRKrsZhGNztnlvbn5FM58Yiwp/XEl3N95ZAqWl7C
	 LDgZ9I8eS0ojUUEOcVZ35X/jAJcBUKvMQ/CXuh6mZl0C3oMgzjiykNx63RCtQKY/dv6PB
	 6Ck2NhbVyqPGEG9cSsQMdS9kLWzwrOyJLubDJA63POszjCCywKNBm6KFoYBFMlZwgd6ts
	 wvB4Uu9vrC8xFCmhsYM0JX9HChnGpP8vbQ2jrKEB0tAmn5Q1qp6RznkIiLhc1SZEBbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795122166;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=ADHyM+iiWJmpqGEu0k2Y5C7oOLJmYShwJp9xNh+Ttjc=;
	b=dVC6YvZ3GLcW6d2Ftx9w18LNhdr8TSMvklCEFavmcim7upf8V96R/26+tcXsULVhfEog
	 /esaelZq0yXdWlZ+ERxbhmSj0jFApR03pjYw8qscRrE0fgtFYPtqynO66rOFEAIufEOeZ
	 GQZEoTt80SZ1XN0JYbggM2plrE4hFAn/FawS7G9DQpVvSRau4V4KRU2G19jBVXFhF1VS/
	 i7FaFg8qjW/UYMyEA0KexPje87e7F4kh+J+2vNP9rpKkxZsAmidJvFisA08lBx9pFGByy
	 AVyGQ+I6tQ2FABu+kw/GUa2oc7249lb8zDi79RoYiuLllUpJollKORFcfSdO8ac3N+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=dBkDJTdS;
	arc=none smtp.remote-ip=216.40.44.11
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19AF606A325;
	Thu, 19 Nov 2026 21:02:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F19AF606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=dBkDJTdS
Received: from omf08.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id DA455160C4A;
	Thu, 19 Nov 2026 21:02:37 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 2CAE120025;
	Thu, 19 Nov 2026 21:02:36 +0000 (UTC)
Date: Thu, 19 Nov 2026 16:02:34 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Leizhen Zhang <lzsx618@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tracepoint-update: check the section end before
 reading a string
Message-ID: <20261119160234.61f65ec7@gandalf.local.home>
In-Reply-To: <20261110000117.1720256-1-lzsx618@gmail.com>
References: <20261110000117.1720256-1-lzsx618@gmail.com>
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
X-Stat-Signature: yfb5ezebu6npj3igiaxsx4aq6ndb4tfx
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 2CAE120025
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19R8NFhzQlVbaS11AaWowP11JoKZgYEYyU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=ADHyM+iiWJmpqGEu0k2Y5C7oOLJmYShwJp9xNh+Ttjc=; b=dBkDJTdSC5nnIqyur80jk0F89oN552EKab/4nWT1juR8end+Qbx3+T09EU1510mtmHdggncKpnyS5y11otgZEvR3hgzPiJvnADlxPQgQugwLRBOlyJt1s19poO4yzgDJQ1DZqhMic6jIEkLrddWFQ7+I+WVNdq8Xny7vclFE4z0=
X-HE-Tag: 1795122156-377083
X-HE-Meta: U2FsdGVkX18Ac52JOAdi5NcNzcfM2XLbqLkWt/zsDzrV73TaPy32fSYiKcS5N/n8zGS0Mc5wE3VOguyH/Da9G+qPi+gNibABBLPVYHwWIysziLYAeHeddVBhD8FTmXVFQvfiRBtQEouq2KffXBnpcOSQjr14+QjxXfM2kwcrVg9vF43CjVC0sfIhM/ItkAQkHz7FJMYk3g/aUIp7Q6JPi00Z9ow84Nd4wCxO9W68PR0oNX9aauO+aV5Ooty2q1LIwsjA9CeoQS/Jswflg5GfCijhWtjayWT0XTsw/Gk6i4cK0g4BX/EztEc2iiH4KYN3kCg47I1DGdgQ75EIydSA5dfmGFmOoVFLYmS3Ft53gohe8689TKedPA==

On Mon,  9 Nov 2026 18:01:17 -0600
Leizhen Zhang <lzsx618@gmail.com> wrote:

> diff --git a/scripts/tracepoint-update.c b/scripts/tracepoint-update.c
> index 5cf43c0aac89..c70c0b076554 100644
> --- a/scripts/tracepoint-update.c
> +++ b/scripts/tracepoint-update.c
> @@ -74,7 +74,7 @@ static int add_string(const char *str, const char ***vals, int *count)
>  #define for_each_shdr_str(len, ehdr, sec)				\
>  	for (const char *str = (void *)(ehdr) + shdr_offset(sec),	\
>  			*end = str + shdr_size(sec);			\
> -	     len = strlen(str), str < end;				\
> +	     str < end && (len = strlen(str), true);			\

The above is hard to read. What about:

	(len = str < end ? strlen(str) : -1) >= 0

It sets len to strlen(str) when str < end and exits the loop when str >= end.

-- Steve

>  	     str += (len) + 1)
>  
