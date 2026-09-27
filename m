Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429293C944A
	for <linux-trace-kernel@vger.kernel.org>; Sun, 27 Sep 2026 08:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790496214; cv=none; b=g4QC0P0UJhcXoT6woVwt57kfqbseylvS+/FJOPyzz7m99VZ0FhCI3OBwi0S8/8Sxvcv6fJBIwg/Hl2scsXAuYrYsjvgGMMlB6bortzudAe7hk21oLEKQcUl3z60LtQG6ED7JpGEo9QqbKVtbtin0NxxulTcxGGJArDvQBzG4cpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790496214; c=relaxed/simple;
	bh=4ZZ2di/+pb9o/IsfYKwMlhKyrT2armIhgZm0R4Ikzdw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=smC7mGptH8MnsVW1wyRbC5X+Dxs/mkrafL667sYIchdccdMvY5UYJfn97/FeJfqlX6wPeDARwktQzw+y2nZf3HS6w60Yz4GCJO/B9kuiujiDm96wAhT7cgLitkTO72QOeJ1V0EVzNlphN/ykF1YqR1ZTnjE1o4WN72crVD3/yGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=MxdPVjRh; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="MxdPVjRh"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49d1fb0cf5eso19218925e9.3
        for <linux-trace-kernel@vger.kernel.org>; Sun, 27 Sep 2026 01:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790496209; x=1791101009; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kH5LGmE2trMrU+13M5071tiqEPhiiJkpOWdRzaL+Evo=;
        b=MxdPVjRhx1bG53C8o+0v578W8o5VGZxw0QOvOS5pp+rixDlwPvSaadkHoI2LC4xIkk
         Iefm5zeamoWMyNp48SfXe3Em84asi/7sjMoxQb6VTHioT/mvyFyQIDtNivLRA2Ye1lak
         9269+/ycYsYnmKAkCF2pwWSlz9z+IkrOwS9eNjXF9yQ8jknfnhFfCpxg7Uz3PSmEPV+N
         pGw9W0of08qlbtwFW1cANpDsC2g45xUaDEDq9gtgGvbiKitIvHI8EWyOzhrq8TFNQapw
         stPB8iDfDfkrWJUhVTwHpLXqQ22VwZLnq2UcZc8kjasaxnnZHQcys3mutkT6qwjUTGxj
         QsgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790496209; x=1791101009;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kH5LGmE2trMrU+13M5071tiqEPhiiJkpOWdRzaL+Evo=;
        b=a782d5wgLljmaCwTehHj8seci1JUYwhWVbARni8Q+jDNfeaYbxIMKMwOwYIYzJBEwr
         atgHUUZ+0VfSjH3VLx+GSOVtpuvoCv1qAALSFb7+4zyDnQmgXc8vk+qawoFzyQ38hC7W
         UNWe20tqEIZmJEZXW8oyGc0W+ydV7/MAEZSfCXh3yywLLiTqJYqefKbwbZwOJ9sSkufF
         og4Ul2px3I2rPJt5Fe5z/bCAiNUTYVlz00XljjbIadda9AnEGqi6Fo+7hSicVTcial3R
         WMMeE+LgmR1L4WkB0XcNDqpehNFdqLxfvSpGTESUiwstcRW5NkdfrLUSrvXqHN0JJIH8
         Wjdg==
X-Forwarded-Encrypted: i=1; AKwUvBwT7slEg5V0unde7xK0W3F5Chesc1dCH5VFhGbvH3zx+ANnehFgQ4HYP4myByCIzvzwvMyC76+9MEdvu/07KVH2Xo8=@vger.kernel.org
X-Gm-Message-State: AFuF++lJ3EZjbvue9ijaOSW2wmt47TlZWDn6koI9SkFvU4doWfvrB8up
	f9nxkNZDgkOu6JpgTM/YOFair0rP0QXf0aP8noe+/kQ6ElAZqZgWaDXEuWP2Lr0rIow=
X-Gm-Gg: AYBFou3CjaFHEOBlSrALMHmarq71oFCB3GSQKWwymT1JLzQeIdc2zEkycP/jAHKxPq0
	8AgiUmylS4+cIz4QycUz4uaL9yJ+sGGKJTDjA6qhDzZCuI0Ofgkn7YO4QnayGZ9nLo1jkNeXOIl
	pW+d2XdHCryb7MHK7ZF/rIsGuFJTWCAXpqdU9Hfp2mrIoiEOfpEpqZPFDCULQVTuVZqcQp4F4Mo
	xQ/og+g7V3tv/tkiMGKHM9LlymeCjUvDdpq5KSSGjRu69L3yH3hd1l0ywicR5+wWe30PDufZYWo
	dcJaAJLjIArFzT3dI9WePKKyMjP00xQ3H0axO3Bxt6bpkeq90Is7jZKY714MyqWFqnplhBq0GTM
	UxoiEYUVMiHhYxxRD5hcZFsB8DepOpf6ZgqubNfw0PuidemGUejiRUOzv8CUF/S+aNlSyTqjhRg
	WHNDNzK2piGMIBBrPqdcb9Z2CuhMvcw9C4DMMsDEAIglVGC22H1rnOpVdL1IWBVKzU7ZxHiFy0R
	KYT
X-Received: by 2002:a05:600c:4e49:b0:49d:1cc7:5ec3 with SMTP id 5b1f17b1804b1-49fe66d456cmr171785125e9.9.1790496209196;
        Sun, 27 Sep 2026 01:03:29 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4a00179c729sm63585265e9.15.2026.09.27.01.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 01:03:27 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Johan Hovold <johan@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Bradley Morgan <brads@mainlining.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Armin Wolf <W_Armin@gmx.de>,
	linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Add TAINT_DRIVER_OVERRIDE for usage of driver_override
Date: Sun, 27 Sep 2026 10:03:13 +0200
Message-ID: <cover.1790495516.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1283; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=4ZZ2di/+pb9o/IsfYKwMlhKyrT2armIhgZm0R4Ikzdw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBquM3DZpAEY/1qXSx1yNsHVv4KnRSueYBYOf66H f4NSu623b6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCarjNwwAKCRCPgPtYfRL+ TmedB/wIL1pKq46pdok16UqLQfrrEc06L1+RBQndLWnrZ8UNQ/TmrVWJXZrAgdr3BPlQiu/LT8s y/6xrF/vMS/zFp7qIdnb8anTH6ixuPChaSqKC2DnX1jqkKcfFMjACp0TnAX4n8Mx91T02TysHdv 8mOCkg7/3j54MfdaS65xcMfplJNqO2KTkpp5fpgvVRquIjDU+FKDtMn2osdxaTOZvRV02pJ0TIx SOhppFGxQvDqR6bHtQvBxon93JPG/CL7EcgYBG23tMtfwTeLg0LC38uF1il7sIUrDM+fpjX1Wqn Wise8We5/fL1fQsQECI75oj/miYcTq7DLgPuqKXYJg/QSkub
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

the changes since (implicit) v1 that is available at
https://lore.kernel.org/driver-core/20260925182041.1025371-2-u.kleine-koenig@baylibre.com

 - new patch fixing an already existing tiny issue that Sashiko found
 - Fix a build failure that I found before sending v1, but failed to
   squash into the patch
 - Added review tags by Bradley Morgan and Armin Wolf

IMHO this taint is superior to TAINT_FORCED_BIND, but I hesitate to drop
the forced-bind one. On the other hand it might be better to drop it now
(before hitting a mainline release) to not burn the used letter to
indicate that taint?!

Best regards
Uwe

Uwe Kleine-König (2):
  docs: admin-guide: Handle TAINT_FORCED_BIND when parsing
    /proc/sys/kernel/tainted
  Add TAINT_DRIVER_OVERRIDE for usage of driver_override

 Documentation/admin-guide/tainted-kernels.rst | 6 +++++-
 drivers/base/bus.c                            | 1 +
 include/linux/panic.h                         | 3 ++-
 include/trace/events/module.h                 | 3 ++-
 kernel/panic.c                                | 3 ++-
 tools/debugging/kernel-chktaint               | 8 ++++++++
 6 files changed, 20 insertions(+), 4 deletions(-)


base-commit: f5f84daefcd92d7a630066635ecea1433ed5eac7
-- 
2.47.3

