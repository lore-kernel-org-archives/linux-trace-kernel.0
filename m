Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344C923D294
	for <linux-trace-kernel@vger.kernel.org>; Thu,  4 Dec 2025 04:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764823186; cv=none; b=dEzwPPaWsJFi2babr8VcuUmWycBAujFvTyYQ9zgOY8yhLs/jz5Wioasp8AqbvW56KGqZ+y1fX2VQJydhjHwx76WcsdSxfR7bjlrGT2FRvydtmSe3DcuwLg9wsOQu/wr5Q8xdDfLGGSpbuLggxRXS8m3/ULhOYzkd6vU+lWULFf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764823186; c=relaxed/simple;
	bh=1v+obDT5FL5UYD781R+2FxUuick0foS9CSHwDNJndVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MMdc1hv6PdBsy4L5DcrD6UG/yWjRIhWCrvgyJEudsERg5FYKRL1UGQv0dlQgfTkCnygAqR0BXxp/MV92hjFM7Y666mzLxXwcL4JDqAFPtY0uAcSelkEeqzuafpZT2tqw2UOuUD6qQNC/yQjp7Oz6mvvZraBF325P/uJt7RAdaY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LN8zRAcM; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LN8zRAcM"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-640d8b78608so369814d50.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 03 Dec 2025 20:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764823184; x=1765427984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1v+obDT5FL5UYD781R+2FxUuick0foS9CSHwDNJndVM=;
        b=LN8zRAcM6ZWMijDqaTN14taBIPCf1WTSVN1h/+zQRsBpt0JL+HSLRnE/8L2pm7JP6G
         HD9TC0Y/zoHNYLEeBvCJHuRkWSikOSeDPLo77egmdohX0hhF97DyoWtt6gA1xZJkowv0
         /TMPxCMev9PaduTtV6gow1Tpi+z3osZgRmZ2UqZqjPCi65JErICpNHW3Ys1Q1szFMS9Z
         HbIq7QCqw0GB9EnYRACRHp7KFa0YqOjZ89Hv/g0D27wS3lN9T++2W1giRryk9DIC4yYA
         W93s4T+cZ1FA2UUt4FPMCvi26Ik7JaLek0HQEFUhJqRgL7mckEFtN7WSBcDrO79J+jOg
         c/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764823184; x=1765427984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1v+obDT5FL5UYD781R+2FxUuick0foS9CSHwDNJndVM=;
        b=kPGjjlgf2hPGZNAPRQJpe7gZbbIsxZY1SfTGOg/D+WF4aVSOMk2vVqcytvFNfTkkLR
         pUuyRAbpknGsz1ue4XNsXWPbLx/wN84C3IQ3eNyk2/F9JoS0RNyUoTDKY3xFOYzW4hEY
         5MuB7T7MAZZMVnzNFkD8c4Lshcu53CoLhaY6qScq+VzNx6v/r5AGGqtld8bWh0u6CGG7
         m8eO9uNpMAKQ8IZsO7lEuCj8CRudU1agcTm1Dgkri4bMrWhTMqLi2543HbhKWWvuNSh9
         UiNrUXJYIm0TkOt21LAj0Oj9y339kBCx6/6yNICRhLyMcgKccmJGjDelFbwWwYqJFsnm
         8jqw==
X-Forwarded-Encrypted: i=1; AJvYcCW85wtBF17FKbPEFqbUCEGO0jaIxMYtJNBGPZwkP0rPEkgfBZyT1OHxPca4GCzdSp5p8MYIzW+iyOLoG61UeHqs0SE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXXcCXZlu5VnDPTLH/HxEjCJ/zd2vP/aDqAm7g/K+wVF/c9efP
	Agu74/C0qZe4I1KfXnECCXJDyPaLkl9vihz2/5ig6SoZwrxbYXdZd/KY
X-Gm-Gg: ASbGncssRB/6RCWBApfDSqLEvYnqTwp9oDcREbFOIzgnxNv0EM5bdNijo61Tj/aOL60
	JWJxkNw7ULbrUeqJmKH6RwsYjJYgIaZNdMXC6egXvS/gy8ruDdCqg/mEH8ZaAFPf8cRm6e9lHKW
	LZgpq1ZFRy6HFyk56BM3J8U94f9cYrLYnBc0CBdWNIFk2JgmxwptSCWpfW9eCtWq0KsYDdwPqDR
	L0dL6sFVtjuFpfSyQ4wYVzn7AOonO0cQGEb1yM1ZOJKs0NpMsiv+8BMfgfk2RPddbqk5RRM+SFg
	VsmeJeyK5m3hfeUEq0LvSHECvQpPUxyA4GAtS30gaxOyMdDfVz4fpZB8iHVA5gyTDClwZs77KSL
	tmh+Y0JMgREZ6yvV91G7bNcBnPyyyJAuXQ2TW4xhxm7g5EhRpggERHkhHm7AAktbX6S1NHAcOmW
	13vXSE7zaqIAqN4x8HXX7XLy+sLWU+3k9teZ7VedUqd6/C++9MhUo=
X-Google-Smtp-Source: AGHT+IH+6A/k1eBrqPWGoOLVGIDgsAJpEnT7ttLjvCmZkGA+Win1vr4rqv9Mub3s+PQhK4zSBz7kWA==
X-Received: by 2002:a05:690e:128e:b0:63e:350c:aea4 with SMTP id 956f58d0204a3-64436fe779fmr3579945d50.32.1764823183787;
        Wed, 03 Dec 2025 20:39:43 -0800 (PST)
Received: from localhost.localdomain (45.62.117.175.16clouds.com. [45.62.117.175])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6443f5a3e81sm246719d50.16.2025.12.03.20.39.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 03 Dec 2025 20:39:43 -0800 (PST)
From: Shuran Liu <electronlsr@gmail.com>
To: mattbobrowski@google.com,
	alexei.starovoitov@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	dxu@dxuuu.xyz,
	eddyz87@gmail.com,
	electronlsr@gmail.com,
	ftyg@live.com,
	gplhust955@gmail.com,
	haoluo@google.com,
	haoran.ni.cs@gmail.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	sdf@fomichev.me,
	shuah@kernel.org,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: fix and consolidate d_path LSM regression test
Date: Thu,  4 Dec 2025 12:39:14 +0800
Message-ID: <20251204043914.7580-1-electronlsr@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <aTARqrMyC36CXa_L@google.com>
References: <aTARqrMyC36CXa_L@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt and Alexei,

Thanks for the feedback.

I have updated the test to use fallocate instead, which is in the allowlist of the d_path helper. I also minimized the test case while retaining the ability to reproduce the issue.

I will send the updated patch shortly. Thanks again for the review.

Best regards,
Shuran Liu
