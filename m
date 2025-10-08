Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781F62BCF7F
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Oct 2025 21:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759957712; cv=none; b=W/5kV18JeO4iEzCb+GYKygj3uY3OeEyk0lG8mqCo5aa4WBu7NdA36yD/n1DGtCfsNXqs+EuxSzdS45mkyDRG9Sv+fYRk5n5QgsA6xmY1+r/R7UNpYDTAsOt1mDZR2JhfScFZPqt+GK0IQSMfmYRsJjZyUIIMEeK/p/BfRKRv5xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759957712; c=relaxed/simple;
	bh=JBsfr1aesD7Pm/tSoQN2ISv7AGsns6r4d51ITiT2a1U=;
	h=From:Date:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MpfOOtwwZEgM1GumNDx7WTh7kqFhGG0MQ55IwKVNwc31L2L2njztLbFJ0dhDvZPkcLSemSbyFWy/SzcIz2LzMcV/UqFMtAwrbCDTG2MQOjQthvGIY76cFt48LOulJlj90GJCKuPku1Hmhu2QCzNXJ37tCQIiFHlfkAhxqQ/vjbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYptFm/h; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYptFm/h"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46e48d6b95fso2386515e9.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 08 Oct 2025 14:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759957709; x=1760562509; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TGvtU6ztqZrVUzflDHPqEVh6RTR0jNPWQnV/VMSP+Ko=;
        b=UYptFm/hQwRJyQCImWQVwhdhEznFDuyJtajmOwo2x1XxwUtcxPUHEWjDvPI7zA0ymg
         6IofvdFUaDp870MFiUMH+5zd64LEYNHr2jFFUn3RTGzVn8KF1tuHxmWUtpGyEEyMrr7M
         0kPjjOGc9nuWNATb++5LWezEroKgyQz/ffR8PmCLVHCFYofNPWwizm55UlMGmHdjSmIN
         rpjd/ddyQSQTb7ygtl7XGKNTtK2qSx2lCqJQiP6pwV0c46fT0olF1Ik8vITp74mZjde/
         Sgzfv3BneqXeVpgOb6pHM5FJC+T63fFevi+m6Vwp/6hm8a3DgY36Ldzv198kZVPxnFqg
         RCzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759957709; x=1760562509;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TGvtU6ztqZrVUzflDHPqEVh6RTR0jNPWQnV/VMSP+Ko=;
        b=QpZNSu5e2IxbsZemT8uupHi/nP+BnnYzhdqAtRsj+Y5qbpf0cN+gKzO9oC9hB+dKlK
         rTTV76lpfbV+IvpgaD3Nn5KrvuUEJ7y/J0geOlGyr2D/mlu4148GluLZ6hKdgrcjRl10
         3/jAurIWNA4CX2Rv1CdFF6gbHuCGbbGiX647to9g3u6N2SiqA6W7wRNvY+Z0aKNYhqOX
         7piU3q+OKFcmLDBc6rukquKhJoF2nBZU+03pmvHPGSbI3t2qyqqQ9PhZpfXKOY2Obzl2
         BOwsV/cfqLuL0sKVLigvqhIkGNP1Omagz2lNZ1mUlKEiIOld5VgMslpGqz6S8x6VVwww
         coDA==
X-Forwarded-Encrypted: i=1; AJvYcCWtF0je2e/jQiij/CVJqAnZv4JsPzQm4W4lNL6YF1kvxt3gcNQuN/MBOV/durSb4YgiGJ9hmBEwQjwGwIC5/3dnge0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0AkMfZGt1lLxrACfy/9iA/yMVTv3eMckQObziRfmxwMLgD2ev
	I16CKH9Ag08jmXoFd+0Hutd2u6l+qRB7S/hrXkLMWL0zwEDZAnHGW5yv
X-Gm-Gg: ASbGncvIsyHMkHHmg4GORdYZWJXVku5zDNwiZCKGSh6VdMTHIHjXsEZWfoGkQXik21a
	gUzCOmllP9brWQgq1YdLAHs+MQNvDO6mamcOw5noHgzPQO0az5HmMDolU3hWa/5BJz8jfieNItU
	DpdRkTHOs36WVbrp6ZaN499C78WXYfP/8Mj4t8BEKVeU6ysiGR6LuGzE1sszMHy7nSTJ7LkDSju
	4DK6cMuiVPn7qHGXTB+NfPXvuRPEvMU38DJKGmDoNF3J5cAHPhBs3SbWBmC6/+1BkqNuQgeefD+
	pCk9FkbgA/XKRgg/Kweln0+yjhOulIRoHRr3nfLHwlpQNtnEO/tozbGjKz9WbS3/ndkXWXmAF/D
	lJj9MKbs09/D03zi4aIdsxAiyijZlKU70oZE=
X-Google-Smtp-Source: AGHT+IHP+VP0VqlOlba/K/aTPk7nK05CBsQlGJMqinsVgs5zeUQOJt/inVq7nvGWwAfjrSQmZurPhg==
X-Received: by 2002:a5d:5c8a:0:b0:3eb:a237:a051 with SMTP id ffacd0b85a97d-4267b3395acmr3188701f8f.58.1759957708613;
        Wed, 08 Oct 2025 14:08:28 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab3d2c1asm21539275e9.1.2025.10.08.14.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 14:08:28 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 8 Oct 2025 23:08:26 +0200
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	Yonghong Song <yhs@fb.com>
Subject: [BUG] no ORC stacktrace from kretprobe.multi bpf program
Message-ID: <aObSyt3qOnS_BMcy@krava>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hi,
I'm getting no stacktrace from bpf program attached on kretprobe.multi probe
(which means on top of return fprobe) on x86.

I think we need some kind of treatment we do for rethook, AFAICS the ORC unwind
stops on return_to_handler, because the stack and the function itself are not
adjusted for unwind_recover_ret_addr call

If it's any help I pushed the bpf/selftest for that in here:
  https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/log/?h=stacktrace_test

just execute:
  # test_progs -t stacktrace_map/kretprobe_multi

thanks,
jirka
