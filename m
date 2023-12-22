Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0592D2554F
	for <linux-trace-kernel@vger.kernel.org>; Fri, 22 Dec 2023 17:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AmtkH4kh"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7ba84e1a441so17437239f.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 22 Dec 2023 09:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1703264601; x=1703869401; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ltRRpZS+EOcPiETxy95NBLjy+e16UT8/TWTaVCrYa08=;
        b=AmtkH4khFMtKHhxoCNqyNq5lGWxBtPBahG/pLvnAtxiABv1o1KeY/a7R80o+SkUSpo
         sTaPO/qskOk7eUmOeAn5q1RuwkZcKkcGK/JEMlHDo2dObpana5sOIjDxS+l3KM4uwsFl
         ieBM5JeB9RcO9E4iKdNgD6KnbxvTB6asLYxPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703264601; x=1703869401;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ltRRpZS+EOcPiETxy95NBLjy+e16UT8/TWTaVCrYa08=;
        b=w63Hyg8s5oPdrrWfEX6ylC3iZIYgV7GOpSIS88aXOINtGkSiGNZdvkbukr0Srr2yTp
         BhP3yC7Eb/Q3evMQLCMfnzdPqV/5iVjTdeQavvz7qwBMkJijjhZt5BvaQ1TOQYp0k+Vs
         f9HIQ9zlay368G2LzsgVrkujv8bT+84uooTkvDWYoRKDXAMPJrjdRYgjI9NwZaqXfu8P
         C19l22+JS8izNjDk/yMiedvbEsWjOU+LNaYKhCra/YTLrrt5NoW9h93az74LZndjXla+
         /hDoehwzfmhMpPW5dtDuOPj9+GKF/fs8xKElX9cUEPEiyISaFgPnyzW3wrG/frDFYwT5
         WCUA==
X-Gm-Message-State: AOJu0YxjGl2HqN2lGjkXKuSsuodvngfH0eze+AuJAKzfrB7h3h1EojrK
	gONsFkmWyfuYgg30ZbEVtBAEUI3IebMeAQ==
X-Google-Smtp-Source: AGHT+IG8x9fpWMWrm5btoGGjgbfKlOW9ON3tdHN6XzxnXT29KlFDVnIHs5y0IVbj/bXEE2sM5V6gQw==
X-Received: by 2002:a05:6e02:1cab:b0:35f:d862:e451 with SMTP id x11-20020a056e021cab00b0035fd862e451mr3120716ill.2.1703264601030;
        Fri, 22 Dec 2023 09:03:21 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id by3-20020a056e02260300b0035d53e82fc1sm1226169ilb.19.2023.12.22.09.03.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Dec 2023 09:03:19 -0800 (PST)
Message-ID: <80b5ef43-7b3d-4af0-8efd-0bb080e99ccf@linuxfoundation.org>
Date: Fri, 22 Dec 2023 10:03:19 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] tracing/selftests: Add ownership modification tests
 for eventfs
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Shuah Khan
 <shuah@kernel.org>, Linux selftests <linux-kselftest@vger.kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20231222113459.4d645bfc@gandalf.local.home>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231222113459.4d645bfc@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/22/23 09:34, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> As there were bugs found with the ownership of eventfs dynamic file
> creation. Add a test to test it.
> 
> It will remount tracefs with a different gid and check the ownership of
> the eventfs directory, as well as the system and event directories. It
> will also check the event file directories.
> 
> It then does a chgrp on each of these as well to see if they all get
> updated as expected.
> 
> Then it remounts the tracefs file system back to the original group and
> makes sure that all the updated files and directories were reset back to
> the original ownership.
> 
> It does the same for instances that change the ownership of he instance
> directory.
> 
> Note, because the uid is not reset by a remount, it is tested for every
> file by switching it to a new owner and then back again.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Tested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Changes since v3: https://lore.kernel.org/linux-trace-kernel/20231221211229.13398ef3@gandalf.local.home
> 
> - Added missing SPDX and removed exec permission from file (Shuah Khan)
> 

Thank you. Applied to linux-kselftest next branch for Linux 6.8-rc1

thanks,
-- Shuah

