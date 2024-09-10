Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7B319924D
	for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Sep 2024 16:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725985422; cv=none; b=sV5VfaX/nAHRDwIxTL8WZGwYIpify/wujgaTTInfIrbFysJV09tPbtjR+sGyB7d01u3GcFgilZqn5IyJWCDodwJRSp7Z1jgaB8h2K+0xFQJUSPhFyytIhU76Is4sHuLmouqZzotMJAwG5g1YYYfFvr91esEnDZ1o9Coh3sbNun0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725985422; c=relaxed/simple;
	bh=gXjTEcttA5QttM+LvxBqEoFRUycgUByM82qJ/zmUKxU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FKCyu+1qz11rVVcEvW9h4mYaRRqPPOM5OtjIeSJks1v7PKRmHrMbwyq6pfbamNr6QP7gddvCIYYNL/Mv8aIPcNT4uH9rhg2z9C3m2M5CjfLYgiLH1T/JLUfWwwO2sc8l51XjtGt+TZFWIHOnRKrkuUflYdlqp7+O71PsgYW8ZuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eVesFppu; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eVesFppu"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-42cb236ad4aso20260025e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Sep 2024 09:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725985419; x=1726590219; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AYa30QP8uHW8yVnRTztEeL2KarXkSUIIYXYg/0AlhYM=;
        b=eVesFppumX7x4b+aKXyVMBmS/OuryIx8vcGxVyEnBi9UHE/KcmJ+/ss7mSUtUQ0dEo
         0posC4HaPvcYtHawgw35gCROTqF941CpXe3XK6mfxB7TJvDJp6fXUxeInfyXFnESuuZH
         w8bU5IQwCgROAyiOkDd4GpXPAL2JpwxcFnTXdJzvJoyJ1UWdC3h8MEi/qWBj3UELhDwN
         q2X59/vX/JkozMFU1LzzBzMwJJxEhJQYgANduhCgVitiHh+uuQ4gAzQTFIEr3WxYS3HN
         twEaBZImhP0cEUz87ejR4el9R3Wvfr+MZwXB/NfXtsYH7aelJ+p7P2bjz9vzohtIJmZJ
         1LAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725985419; x=1726590219;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AYa30QP8uHW8yVnRTztEeL2KarXkSUIIYXYg/0AlhYM=;
        b=Xqs6H0rXO+NW7k0DsPiUKSQH9/X/pb/CHeoP93wACvMXRrHv8K4Wnm7d0AxZTv/t7X
         mlEQ4uoWqEnUy2h0rFyeQrIx716TEMLWQ53s3llCE4MlD6HD+BmCf3ejB7N1nKfhtmNu
         T5x6JGBw9DMFyntaU7L7AMkQnxhvUCYTAaoA7ShXWAzrfHiTvCkMGnHAAdTRgEvYwpzY
         LdpE+qe8YtCcKCtH85sXl8h8h/y/g0nWnEE44/r4UQppQzkqS39e6uyTetpeYl7edcBb
         2DO8qdz3zFVUzKXXcaXeKTcVAqFnGFxmhYRY8M3yg4oCjSV9aR8Q4TvVhKQBTJSOaDkb
         WkRA==
X-Forwarded-Encrypted: i=1; AJvYcCWv+bzQQgruicyx4uxxDcGVcP5e0S6icA2ZcFVBB8besEVn+51OH9eqIs1zRG/NZBc8aMTQTJv9a/Nmer3ge7Gte6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyN/ZEoErTebYBWoCWa9YIffqN98xHhNrNJIV8Zjan7rQteskU
	5V8T6jONn+VO2GuUMdlvMYx631Oew83ZpQSFiKnjWggNH53erPOAAbk0kzqw4reaUwkFtbi2OEO
	gESKaD/w9ybW47EOVPA==
X-Google-Smtp-Source: AGHT+IHF+DLdSIrtOimcbKrwLaVS9XMpj84vdlov7q3dILQ6UN/1Xtu53T2ADmbOySXbsfAXdgrBIxnxL+rzsM6t
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:600c:520e:b0:42c:b63e:feb5 with
 SMTP id 5b1f17b1804b1-42cb63f0132mr167875e9.3.1725985418935; Tue, 10 Sep 2024
 09:23:38 -0700 (PDT)
Date: Tue, 10 Sep 2024 17:23:33 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <20240910162335.2993310-1-vdonnefort@google.com>
Subject: [PATCH RESEND 0/2] ring-buffer/selftest: Meta-page testing improvements
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, kernel-team@android.com, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Following the comments on the original patch [1] here's a set of 2 patches to
improve the selftest.

[1] https://lore.kernel.org/all/20240628104611.1443542-1-vdonnefort@google.com/

Vincent Donnefort (2):
  ring-buffer/selftest: Verify the entire meta-page padding
  ring-buffer/selftest: Handle meta-page bigger than the system

 tools/testing/selftests/ring-buffer/map_test.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)


base-commit: 2fcd5aff92aab479a9a89cfce2dbc9c6a9455b4f
-- 
2.46.0.598.g6f2099f65c-goog

