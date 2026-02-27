Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCC43603C2
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Feb 2026 06:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772173096; cv=none; b=QQvpy6JjE0ey4fJvEs/ouUIuREIrmxO+QPL7Kvt+TiriX6Y2qErjFagdrW4gQV5P6v/my1f2KqVMfdu4V05kCM6o3efaeQutj0aWXNDn4cKMlxlmsKpUWM8AX76qAgipOiR6VKtzyFw9nFYj7PhbN1C33Qi4Hbl1tFvwfiFndhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772173096; c=relaxed/simple;
	bh=xtaqGgz0rQ0tjyH/ErNTLu71rauDdX001OKKvtvPx3s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UW38GTAouXL5IzbZ3Thn/EHX34XjdmH+zWGPhBdX9VH1ALHd9QEZeZMkI2qKISXdCEqeCgl9oYUc1g3uoWLi9SygcBLS/1ntDAv17kTrZpYhd5EphDYWsd7TqnyZAh0J4m695XSNxX/QAKULI68aWkrkof6X7EKfrVE8bew2OOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WS8gjwFv; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WS8gjwFv"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-4327790c4e9so1088208f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Feb 2026 22:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772173094; x=1772777894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9GVtvXm72TcUE0O6MwBEwQ8fveVVC9XHCdQUSyyFzWA=;
        b=WS8gjwFv+Vbo7UBTYU4CZzL+togzau8fbR1qu68l4wAGuIycbg28JlZe3DtcsMwfdd
         8hj8+/9JTrgXPPMF0hkJRYThrE5FkdCPmpSLGflb5mWwQWK6p8X7LTjdCJ9m4vkJypOQ
         MNd96V5UgFRQ018JTeJ6CxIYboywC0v87Yui84p4Fl6WOHEF1J4643IqNxWzxE97e4nV
         g/ybFjkUoIDH1Jz+4IS3H9YSry1B5i3XZXJ+IaQbg3SNb9Hz/w3wldMU0o4il3e7RGR1
         EUCkdYlj0Gz9B45TSfURkbXdTiVo/RcQRF0swSKJpFIYLXB1naRG8bh6mUtoL6G2GLnJ
         lo4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772173094; x=1772777894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9GVtvXm72TcUE0O6MwBEwQ8fveVVC9XHCdQUSyyFzWA=;
        b=V2nUZpAeqBhM+pnsKDAa989d81w0btXhgWEf0oI/KnhIflSpn5S0MIj3XZkilqMcCG
         kCMzqBENDE/Cl8nRfSRYI0LtMDl6VA8cW7C8sD9TadnLw1bSlNu6e6hxVSlkZcGmiKy3
         m9EJBg3bfpQFXGv4cU4YF1XNP/q2Mg96LdNHfrp+q4SeeIqr55/VQO4oihDl2KpGhgmh
         6qp7eYQN4w5EOtoeZV8WXkoajYgzvJNzqJ6Szg3+k6GsB2FL6x0zq80EEWoD3PE5Wevq
         sQ2m2JZUqXAb0da+fDuHTkwyw7tVqYOxvFh5rdtYSesQKjeiy2mPQCGrmLEcpzQXNUqv
         KL0A==
X-Forwarded-Encrypted: i=1; AJvYcCW7WAMP/VW5L9ZuwA9X6zwrdzwz+Ndqm/yCzDErGgbGIQF9GnJk6oBROJNMuIsf3sBFWnmRUm2Fdmai7x0rTBDt/ZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiTDdxBFYr6qD5PMWWJJpNMuGaYMOFg52/IbSFF61Y4hpP/ILf
	kdwxvbfi3gezs/NZ3ElsaAUrpOQ0gTxrg7df9OrJ4tQQDDiN606zE0fJ
X-Gm-Gg: ATEYQzxVhdCp9RAPrGw5p7F2arsQrgJAffa1gUkD/QLTgy8yXD+HyFHvqqLOV+FY09r
	Zl0EKuOjr0kUA8uRwqYqHjvCBIhg6zrUhXLKFqu3sVRdpf0r+HoCSUU+4HtipyWPEo0DUOWPlQI
	MvS3xubR0Ro/fD5MbawwOzCrPvyDkOCw+fVFojvDYryPDORjRcO6Q7jc66hak7tUUhdJ3jjFSio
	dmIlWJV4T7bmohbUVlK2upEGEnt1CXUFYbcI7RpD7Eh4duJ6+rBCw+HJNqRS9K87wrERk2kZorI
	5m1BEvJuRN4RyI6Adq/DuPhoM1xoHFhm0P0EOFw+wYJ7DL06Ulifdkyn3mGJkhyNDVlTOXtn7dO
	m2xwxOl7M9WS6HphxoWbTbuerXpqvmnqkWxwGMRjtVTGbio7UewGoCn3yWKU9q7fzWH6W7QkdR2
	pHN6lHEIz3JIm0V0VMnOulGl/1SaGrG4oeQGdoSGzm739COdCgSA==
X-Received: by 2002:a05:6000:601:b0:436:1934:d234 with SMTP id ffacd0b85a97d-4399dde5f46mr2389104f8f.3.1772173093487;
        Thu, 26 Feb 2026 22:18:13 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.215])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c71b498sm4523755f8f.15.2026.02.26.22.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 22:18:12 -0800 (PST)
From: Qing Wang <wangqing7171@gmail.com>
To: syzbot+9ea7c90be2b24e189592@syzkaller.appspotmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	mathieu.desnoyers@efficios.com,
	mattbobrowski@google.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	sdf@fomichev.me,
	song@kernel.org,
	syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev
Subject: Re: [syzbot] [bpf?] [trace?] KASAN: slab-use-after-free Read in bpf_trace_run3 (2)
Date: Fri, 27 Feb 2026 14:17:59 +0800
Message-Id: <20260227061759.1126681-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <69a0544c.050a0220.3a55be.0004.GAE@google.com>
References: <69a0544c.050a0220.3a55be.0004.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 2d14fb6d0ed0..f7a0116c7e46 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3783,6 +3783,8 @@ static void bpf_raw_tp_link_release(struct bpf_link *link)
 
 	bpf_probe_unregister(raw_tp->btp, raw_tp);
 	bpf_put_raw_tracepoint(raw_tp->btp);
+
+	tracepoint_synchronize_unregister();
 }
 
 static void bpf_raw_tp_link_dealloc(struct bpf_link *link)
