Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97DA1D514A
	for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Jan 2025 23:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737676484; cv=none; b=qFueBqtvNv4LswGXuH1uXztFd98MTtYBD1Qmx6RTltDd2X7wjhR3Xt7dKdWREVHbLH0w4hA7VMFUTt2e4kWo0qXOMihnzXpZf+GJ9xzQVorRqK/rDes5suHEl5PlTlqtGU46Wa30hWTk2B5OFBxOWZhOpRT55Ot4ep4ML+L8pws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737676484; c=relaxed/simple;
	bh=aIjcLrJGlFasL3xI+iSRoak6ztwXJDst3i/cX4ji66A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pi9rkTb5HJPNsz80ZqZ4xfgj4KukigipB03Ni6esbm5I5bQfIpyY0LQKvedjoKsnkrOSLY5400CrCfXwQ3jC/SijayZb0NMug2DDaJ/29GrBHZPchajGPE2zgCz3FE4Cw1rQuELFtGIcBn2lDkPn5E/lrGH8T7lJ4oeKyomOHIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QhZ2uiD0; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QhZ2uiD0"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3ce7a77e5a1so4494515ab.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Jan 2025 15:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1737676482; x=1738281282; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sWwhFSgKs1C9G6QeDd/12wgSwtiz/3rmZd3mhm86C7g=;
        b=QhZ2uiD0xxP/uAD+5/R7Vc3dGhtpB9Ao+OHngkR03uhBDRG2e//ZGPVv095EHk1ib6
         tu+9KPZCKNY5kjwnGNxxk3rLyurXGJjbgVSyrk5EokcxNUiuR0MKEird8kq+muH6M7Wv
         cmQOzj0C2VoRh2tVGCR9l1K6J1cGLZMLtvhcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737676482; x=1738281282;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sWwhFSgKs1C9G6QeDd/12wgSwtiz/3rmZd3mhm86C7g=;
        b=rLAOLJKhc3BvliDHZoLzBquE8tUy8yJzsZ21Lx9AwznMjaryxQNfJP2xt9KDN6Vupx
         u9WZEJUMbgYQtBcpP+xqUHC6J4bOGv+vSKmsjJ8CfpALjU6jvyCmaGgL0tdEeFbHeyKk
         dQvtObIL7iUocuXBnw9K6qGyp+dF+exmHgVjcA0aXvnpt7sUJfpCos6mvcuv9+DiXV8M
         FS6cufFqU2VouDJbBgVvaT3rGTcBKtyPuPc53UfYFTz2qIYrXWqSkyepKyD1dx/qb3Gm
         2g7L0mY+JbtCWquNkmp9UbBAFo2VUHyVnYn5tDG0irUSdfPKIjLk56EmFfRqegMcprYP
         d6rg==
X-Forwarded-Encrypted: i=1; AJvYcCXCMOpmqab3kuVrbGn+yYP9HDhthY+xAbxiJQ3PPfpxtbKq+A+nT9M6KYzAvMmQohcu582O8YudTiuLKJYpBF/qjnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrMQjjvMFzfYaUzgMi9wanLUgq7BR1mnHu2VIqFWh8I5GFhF2a
	E3YJY8CBWiBKtruy25/ZdGa4nt4Q83fXVH5jGS8oYzYZUZOmVxpzuW5+R1Ljp04=
X-Gm-Gg: ASbGncsOfsCxcFZOZ3ZQgcaKG1djdmMjmqZP4tpKl1cDtA9UuAfLLKmnefF2CA3Onv1
	i5oxsNnhjIFhf0sGLV5s56j4FRfoFmSZAaiUXqgM+E2tIqcy7bpjiIPSLqK7JVS/pK4OjIFndyw
	pN/apSnYTF0bN+8M4S9vvA8zCsE8I2/DvI7tPKrg/D1GVHnpy3FEDlvvv1SJxPkqSd3Ew+KZ2vL
	4RspBR8Tvx3ggrbMt9UkRjY0/7E9lTXwMOx+xj2+lov5i0vKzuhg1n16bFZ6If1GF2i69MH+PVd
	FnXMnlQCy556akg=
X-Google-Smtp-Source: AGHT+IFwbYB9CgFYSkoho5dmcikikH3LPzPdWoZFU+D7+LOCxiV5nLqk0Wewub3OPu2i8idsAytp3Q==
X-Received: by 2002:a05:6e02:1a67:b0:3a7:87f2:b010 with SMTP id e9e14a558f8ab-3cf743ab4fcmr202063935ab.5.1737676481970;
        Thu, 23 Jan 2025 15:54:41 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ec1db6c3e3sm206904173.87.2025.01.23.15.54.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 15:54:41 -0800 (PST)
Message-ID: <d39de60f-c87f-4c59-9226-9080f9008f3e@linuxfoundation.org>
Date: Thu, 23 Jan 2025 16:54:40 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/tracing: Test only toplevel README file not the
 instances
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
 linux-kselftest@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
References: <20250115191758.35b62738@gandalf.local.home>
 <20250115202607.00c6d353@gandalf.local.home>
 <571133ce-b4ae-4a9f-8601-443774804d1e@linuxfoundation.org>
 <20250123172530.474e873f@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250123172530.474e873f@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/23/25 15:25, Steven Rostedt wrote:
> On Thu, 23 Jan 2025 14:56:55 -0700
> Shuah Khan <skhan@linuxfoundation.org> wrote:
> 
>>>
>>> Damn, I forgot to add Shuah and kselftests mailing list to that one though :-p
>>>    
>>
>> Do I need to do anything or is this taken care of?
> 
> I think you can take that series. If you want I can resend with you and the
> mailing list Cc'd.
> 

Yes please resend.

thanks,
-- Shuah
