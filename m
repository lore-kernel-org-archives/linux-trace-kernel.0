Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6F9261B6E
	for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Nov 2025 01:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762823054; cv=none; b=AKXm4U8cM4InQQHMhg3a2O89IYcLYP+qA/j28nPfIIaCphso31cmJKJvr97sXCtVCMVAK8LBNGxUNglDYX/optE261Ex+RJ/59G6F3fQYkR8W+0qd9wDr3e+XQtaTFU1QpEhR0uyNVz638kRfczak4ZHCnK3UIFFwB6XhtCmMh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762823054; c=relaxed/simple;
	bh=DTdn+TVj4y7K+zN2UdZO2AFswxa/7GKErpCpr9EpG1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XV7OrlN0UgSi47fOfx1aEAL8pcHP4OKG5scH//Zt601vucVeRzl0CRNvhgIK1QZ4VD+Eb6ziU20qyjzAOINyBErAUrca1wtgV/RPkFJkOGUH+SsDp9e5ZgFpDSSJRYdnPGqVvzZLh68fIMHQI0NQu1gi1T2tNXSb9lnijnYwlB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WkQYLSwa; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WkQYLSwa"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-4331e9cb748so1427035ab.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Nov 2025 17:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1762823051; x=1763427851; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MldjgzoX1SZmnBCXHrYUgqyrT5ShEUH07RGZHBRdusU=;
        b=WkQYLSwa/insdvvaKQLr3wLwer6iZ/ZXyirwn7wVeVwJU0dJ9xouFgHBxgZ3PvXlHf
         CTQuKA0cRcLAXayJu5kHZfvpWLm3dO0WGY4/0uIKI3d0EdjOilYUNOtK2q4RS6l1uG05
         C1RzK8eqMvBla/Z+V2+iYp/WkTBK78ZE+vlqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762823051; x=1763427851;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MldjgzoX1SZmnBCXHrYUgqyrT5ShEUH07RGZHBRdusU=;
        b=crzmxzf6mQCCn7TEYz0aMiVdrdbabZat/UmIUbhKmK7Gu2tSh8UOMV5en04ffTZsFF
         BVV/qrNWCNs8PcGMw3lCKPbMQ1V3Enw2m04IYqaheiFPuaagtbxaB/pb2YccvWc5pYtR
         46oHrodEn7RrhYmhNOItsUJexTMTC7QA/jHGOylTTR8rdgauJfyZixeYdXsqBMBLZRrv
         PcggLB3wzxVNS75/PHUNwOr3FN0eE3ixz0P8mTKgWXkRt0f0SNErQ+z7Kp6kUOkQPsLi
         840hg1ToeSJKJpIlOWh1yPNzAi4iotdu+e/Fm8mJYTyviyYRVe8HWU+t2bVWJyrvjRVL
         YOvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBkN4Sh8xVEpERAzPwWbbBi4Kdu7o6uDz3Z5Cdj/LLSo7NK4FCZnXOk+MrE7nnkv+5enPQc+dsf9R0qKrFBxCjJfo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnoqEEXcTIv7G+3EeXERsA+gpDwOvm3vLezwPPE2H3IMnuBGxV
	UrbyptRq+oXhacUbk1vj1rnVe8W0lYLOadyO3gICUDhTgsoBw2qGdoTpZX+Kqz6MGFg=
X-Gm-Gg: ASbGncv0kNWLbvgcP5yWbbpJebsWEADZf7JN7IncbWQkjd/6hU08Wy+ik2ivCJV8UZw
	Cb4tzTLS2EvipI21iEeyFuCPGhaSgVSBXrhwrkBEDYLCmmVpxhr3Ar/GHJNcHGTiZbokMq6jtrE
	75SYbTok8mvpAYDFRdxEoT5iqwzbAhmqelUhL9d6oXk062plXAS8QdewUUVwFUNCCPDO3FPe1ap
	Mp5PdKpc1sA/IT0CLmh8AkRnM58bSZsFKVf/9JVQU+/OSritPb8KW7mRn6tb/4mwsBXt0JiqMsZ
	qGKF59svs7MkqusW/mg7DmESoan90FO6/0+kg/7fT+iUxwH3l5r6Fl0TQyeyWSbGQpjPmksmqF3
	cCFhEcaC4XuL3YWJJeQdNj/zWHUc4rsSPE+p9yrKAilUjlQPN7sAlbrfBRUx7s5McPLEygvAvl0
	kyBY3JWH6BbmzI
X-Google-Smtp-Source: AGHT+IHCAPfObFCTUaFPUpafgOR5ZP0PrhCGHCniJcUGtCxxVGCtpG3U48p6kW/uACwO8atqxsSGWw==
X-Received: by 2002:a05:6e02:1c2d:b0:433:794c:8486 with SMTP id e9e14a558f8ab-4338be50e90mr22249085ab.2.1762823051177;
        Mon, 10 Nov 2025 17:04:11 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4334f457610sm61159575ab.13.2025.11.10.17.04.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 17:04:10 -0800 (PST)
Message-ID: <87d3c405-5cff-48f1-94e5-86e30d29c5e5@linuxfoundation.org>
Date: Mon, 10 Nov 2025 18:04:09 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/tracing: Run sample events to clear page cache
 events
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
 linux-kselftest@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20251028122724.4bff9853@gandalf.local.home>
 <20251110171432.51364be9@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251110171432.51364be9@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/10/25 15:14, Steven Rostedt wrote:
> 
> Shuah,
> 
> Can you take this through your urgent branch?

Applied to linux-kselftest fixes branch. Will send it
in an urgent pr.

thanks,
-- Shuah
