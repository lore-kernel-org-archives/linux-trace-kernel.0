Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF89E2E54D1
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 17:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783704678; cv=none; b=eFud0XgKqLjcnG8x+08PjJKiZ4t0F5cB82iFkmxel7oVJPAWJwUBYkQL8qkg1Pb4+0fTBqv/bAZvVLU5BvxchxkySVxX/01FTTGMjoKhm/dDpcSi7Q2J78Q8XpgOgxCGHNyFPuDnKYuLHUfHDhF5Zwd9yzhKBf34Q50gJDx8gxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783704678; c=relaxed/simple;
	bh=z2C8CVEChR8wGjCxGwBW35WZ9ORNbC6kr+MOgf81bCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VLRmiosoXeZfHNtpBXCatVxpAMqyEOrJswrpmJALp75nh/fqE6TQOHXTkjZVb644cfhcQD6YqD6SnI8ltf5jdbrThVWzBbXYY4zY1R+Kjt9xwaAMZlKGUVZrmB0oA3cjZeeyZK1rZpBhM9X2iqvhPGZrdSMW4vBhJpx4WhAcS3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f63QTJp9; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f63QTJp9"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7ebd88be784so764880a34.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 10:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1783704676; x=1784309476; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l4+NLBnB0rHrMKuhhVwyzWB3Dd7RcWNPm8QZ4toNsA8=;
        b=f63QTJp9Cw65pGJsUDqkHZO2OQimp8PM815IYB0idpMJAn9mm5Y4uwpTi62eniTGlO
         Soy8V3qvjzWW7JeigKx0oxC30I4hv/04AEWpybeFbBhmK03VuecM+dQ4PblypvScOVc0
         Ko1iQ+YsHxwGXXhfSOqeG1/H1lgc7j/4exozI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783704676; x=1784309476;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l4+NLBnB0rHrMKuhhVwyzWB3Dd7RcWNPm8QZ4toNsA8=;
        b=gFeMYqjReHYySyKbQhHrYB9zvEjETf+7hdQaa1ipsChG9YSK2xFnni2L1LIdQ+0QDl
         0rN0R4BQGLo3D46ls2DQkwcYrlhUZ19b1g2y+y+Q2CAj1lCyDJcZJ1BhQoepFbRguEK0
         F89WubZ5F+SlV7GYVMUM3/5cEq8ufL39/aGY8JjJ5hTn4fEjK2uNgNmfObOnfdVf+n8i
         urZbLS258RL/+moTDNMHzCuYpnmqlNdst/9xDxNTToqDA3WkzmXTzQenvvA9DVvclTmk
         skHtGZPNWV/18J0JOBY+PCEICAhW/MRDBHju1XdlwoAqsdGtfdrmFC3PYkSBW50wanaC
         jEmQ==
X-Forwarded-Encrypted: i=1; AFNElJ+xwU20F0JZ0TqFf5LLZ2DJbL1m7+GbdTNvc0xsn5nlLXC5CMSlMdj6ntRpjQ6FPC76HC5nUE3nZb+/RbeeFtQmOZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTbLDHSkAYXxhCq3YXtJLpBnn/cWnH3NaRcPKNGlhnCcrQ8t22
	B8CzmEQvf7Y6jETAu8pfD64tHmuQ71DAuBHTcwfOTJTI16oBGUoXa0DadQcwZbYhh5ApEBpG62i
	CQo69lLA=
X-Gm-Gg: AfdE7ckpXNZMhbUu7AoGSiJCnYGB0esHKTBxcQG/Vl63gTcugSbL72/y1nF5tJlMEf6
	toVU8ukD0VLQ4ENvZjOlcnOJeDnaMjKZk0p/IquYmUGNHrejzfel2oZ6kLtwnOx01ddJbN0jRRk
	rLLGjX1NBFUJlFx7R6uZ+4tpDjqWF3uG8HDqw5M7qPIJAr59LxkfLa6YrXOAkXoGCFP3Zm6TRmj
	C0+Qt1p5c9Zz7Y2wwCrRb8R8FEkutP1z3V2nP5VzkSrmA588nGZ/NgFcCV6snsxSA8SkRmpYIhW
	I+VCs1jL4wEuLJaBLSf75enG7+MiSOSBeKBxR+RubNytF2apd7mWxK5tdP6R3A8O9y6y+aTwUbf
	+AEoQN88kAV+Tjcj3E15aevs5Bp+G7M7vS3vUgzaq8ZD+0N2kv8ie3SQ7PU2C//fKkJZGUtGwGo
	HMP6hj7UOb0NFfb82trC4dUjaHzpWThi3P
X-Received: by 2002:a05:6830:6119:b0:7e9:e709:44f6 with SMTP id 46e09a7af769-7ebcfe99c23mr9582153a34.12.1783704675799;
        Fri, 10 Jul 2026 10:31:15 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcb2bda95sm6635283a34.24.2026.07.10.10.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 10:31:15 -0700 (PDT)
Message-ID: <58d4411c-000a-4031-8a0d-e5858f056c82@linuxfoundation.org>
Date: Fri, 10 Jul 2026 11:31:12 -0600
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/ftrace: fix spelling error in poll test
 comment
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, shuah@kernel.org,
 Wang Yan <wangyan01@kylinos.cn>
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260702015634.366201-1-wangyan01@kylinos.cn>
 <20260702142719.4e5f6ed1691c6dedaf2a0cd6@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260702142719.4e5f6ed1691c6dedaf2a0cd6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/1/26 23:27, Masami Hiramatsu (Google) wrote:
> Hi,
> 
> This looks good to me.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Shuah, can you pick this through your tree?
> 

Applied to linux-kselftest next for Linux 7.3-rc1.

thanks,
-- Shuah
