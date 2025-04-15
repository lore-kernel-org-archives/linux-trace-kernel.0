Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2561581EE;
	Tue, 15 Apr 2025 03:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744688784; cv=none; b=UFyD+u03eH5IHozLXvg7zhhJ+rLGTxWjam9YV/YvrbPkt5RCJN3e757kpU3IISSme1ojBVrdDNxL9Ni54Rsn1g8NdH3wKzo/p4gmtYfgyvYR07RLYV670ZhdscmzsfKs05D9bpbdWqy2qCrAgmvI9EKGbE9nqBJWmVi/fp0AQUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744688784; c=relaxed/simple;
	bh=bw006OWHFZGFjT/xjrJoXgiwkZZvm6j1+QFK4WAJNEE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eCDPIfudQh1L3ZQR6kmwfZ+aMcTrnDG7LpuDs23Hp7ni7IrXk4xkfKMpjZegNR6O6l0pVECSka9WnhsnqA/0Yi31K6kbS9jq45Sxo+H8SSr8CoY0Qr89YFTLvufpGQtW1TZoL8hNd3SlZqrNLbDLDkXcx5B2ZDNwQdlMJGw4AxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mP8658t3; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mP8658t3"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-736b0c68092so4279174b3a.0;
        Mon, 14 Apr 2025 20:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744688782; x=1745293582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tm4kKqRZsJU0OlSbpZW8W6mIOb8bsKwi79vQfDW/w70=;
        b=mP8658t3x8nKZi/bwf7OdAtCvZgxE4LdM/EfLdEctUn7VDJxeAX5BIi1j33cnubZuC
         GqZ5JxnEeJmR+e1p0634n0d29i0Bi7MJMac79YlEIF1AdKNVnWamaiBSo9fAkG8QW/Ea
         wLxPwU9mfVfkHlj6fElzYF6Bu85zfj9AaSPVpDAvgb0nrLJDGAZOhso/ybLcfP7JQkWh
         OXeQ4MAQwgu5MtN9NMiTVcvr2MvVopOCeLp8sdYQ/X8wkdhSGmoDfszB9QbyOm2aY7mR
         oL+vRJ+xE1vC6oPLfnjKn5J7AibPJSzSlSXfnn9cJpFLE3y6k0iEoZ4e022vZqlFYuij
         TZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744688782; x=1745293582;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tm4kKqRZsJU0OlSbpZW8W6mIOb8bsKwi79vQfDW/w70=;
        b=qdjmTLIQMzUfc5OFgamLVSxX9Cx5yXYlU6KqWwcqKY5xiiOpWSMKQBvFOtNY2X2L9c
         N1v33ayl/tlhHtH51punCYW2EsqH7yUuT79Iw2AOe+g8LJ9AmPeFH160IsI7vWfjOqpk
         dbNc/1k9HYxnLP9EzuQaGaW7zqeWMPUIZyHORH/H+Q+YwlMn6DVZr02lBL2LstS0THZq
         v2lX6xmodZhDxsnksJT4QguFzs9X+inKUd8xgsuK9G3xdebCffVVx4fRKQoSZ+E/FnK4
         a92Ndj6Gz5ftS7JXQ5HqurUfzTg6cDKqODX8h4R+SJfGpx4kb7KCX37FLtMG8LA7AqMF
         kBzw==
X-Forwarded-Encrypted: i=1; AJvYcCVMG6aPzID8KFrz0rLX/uikATo8H7RHVyx34KT9CP5VOgzrS7GKeb4K15ifWp9K7hzs3Tk1pBpJW6E=@vger.kernel.org, AJvYcCXVE4Y+qp6juTLGcBufgk0HVVOxZYAh3Z8yMIGX46Etwv902ju9nQtt5gp6Mh2caYirqn3We2md2xME3y5FBtvW+H9e@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm0bgLaPG++5faqRk00e4IXTaprklKaKrZifEiEqZWvqhErZ0D
	oM4beLbkxY3F/CiIJDZJHWWLPAf/xI3dnC+u3uaimEfGTL/8nzeU5JmICw==
X-Gm-Gg: ASbGnctd6dBDqpSM39WpnGraZabM6AgxUc7pGTIMmquPUUBGA5vLRgvvQwdZ67V2loP
	y1Ns1x0tKIWiH3YAgHORXAtTcH8UMzwjRmyEXdYTkb7pIMWag71urzbEZuA4PWsj/QFkFdfOWJ3
	Dg8QQTSv+AtMfofElbg542WR16oYFhcteZKDaLAjv+aZNxmHuwxsKWM3RDY6Q9xS66aZszi3XdM
	jqDxuw+P37/FjVzltjgyz3Jxu142/W+sRNLInEM8Pvb+4Ej5GYuSqoDj5PRGvr7xVwcMe4bI8SF
	Y5g7ynUxNJqIKuS16z6R0qgLX7NfTCwTlx+YszwW2C+4FZHUYFs=
X-Google-Smtp-Source: AGHT+IEKTX5XjfMZleNquSZckdmG7mf5XcGl65IGZBMGfhu29ouvvpsp9RkjSeSsbV1cf8G4o44Rng==
X-Received: by 2002:a05:6a00:4fc7:b0:737:9b:582a with SMTP id d2e1a72fcca58-73bd12b3127mr23039398b3a.24.1744688782320;
        Mon, 14 Apr 2025 20:46:22 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd230f164sm7438327b3a.155.2025.04.14.20.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 20:46:21 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 9813D4209E44; Tue, 15 Apr 2025 10:46:19 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Kernel Tracing <linux-trace-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 0/2] Table of contents refactoring for tracing docs
Date: Tue, 15 Apr 2025 10:46:11 +0700
Message-ID: <20250415034613.21305-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=693; i=bagasdotme@gmail.com; h=from:subject; bh=bw006OWHFZGFjT/xjrJoXgiwkZZvm6j1+QFK4WAJNEE=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDOl/rzFMfvferFh7e+KvKbKndTJFOzVnJOoHtlt9b47/I 1G6eM7EjlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAExExIGR4aC/5v8t2oF3es08 d031Fj1sLHyhxXnJn9i/75v+5P8wM2JkmFFaUROqG7HyzdrXTl/tM96l7HVxPXFwj2FomdTnled nMwAA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Hi,

The trace toctree refactoring series [1] didn't make it through 6.15
merge window previously, so I forwarded it targeting 6.16 via
docs-next tree instead. The patch diffs are left intact but I reword
the patch descriptions.

Enjoy!

[1]: https://lore.kernel.org/linux-doc/20250318113230.24950-1-purvayeshi550@gmail.com/T/#u

Purva Yeshi (2):
  Documentation: trace: Reduce toctree depth
  Documentation: trace: Refactor toctree

 Documentation/trace/index.rst | 96 +++++++++++++++++++++++++++++------
 1 file changed, 80 insertions(+), 16 deletions(-)


base-commit: 43e9076a00b17cf8115b4bd4d3b2be33a44245ca
-- 
An old man doll... just what I always wanted! - Clara

