Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4763C4A986
	for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Jan 2024 13:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yxRsrQRP"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40e552dfa5dso9973875e9.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Jan 2024 05:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704894718; x=1705499518; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l3M+d98tOIIm4IOTBkd2oP6mZqlng0NqncutW5ci4cs=;
        b=yxRsrQRPwZy3PVin55ynHCE6KoMUxVEGs3/+EwVf0q/akuouPZ+V+B2J7T+si9+b48
         GjtpRHTH1ceeJZXLhZRabaWbJhVRBjS0AiZ1eAXx+sjR1tFUk3E8pN0Q8B3lOUo5Tc9y
         /qfb3QrKHwz/1q7nnows1Hh8QVwCj7yg2YNmXRrnG0qx1UhPbOT62eeJ//NdvUg83a/R
         /KP4eyrg42HWp2ygwgY9tWj3e5rklC48KSJGJMY9Y8AGdZ1caA003tYrnPlZwFSI1nTs
         fyQUAS/ZGB8Ebx/LeQ7HRLLd4huP78PnP4vBiy8ufpxIexWjShUIpoYT0U5Tn+zNHsId
         LlqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704894718; x=1705499518;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l3M+d98tOIIm4IOTBkd2oP6mZqlng0NqncutW5ci4cs=;
        b=YxBy/aIuL76bPs2xn69w4x1gbd13w1t8y4rhjDNvPZRIEt6Gg4iDnyoGhEsQlKT8mr
         95crvHoiFAGZ0aZVbrrCGkGU8ToN0kT64pdPNWbj0oDgatH8/IOeooZLBISi74/ml6mh
         mQgkZHawFRofdJmi0PZr+ZTzfeMCCHIazQF8VR0kdDmMkZX7jfVgJM+6Ab8Xzth4iqlI
         57s5XslFF0+z5RJGv782Dnyad7diHKbYg+82iPzbdP1cu4cEMlFVR1ekh9sSFhu1iKOd
         w3j3SGNVK2esYNjGPziYs3p3avXtbpYVKS1qJdH8ldCQwMgAqoGz/FrG/VnPM5qf4m3m
         OIUw==
X-Gm-Message-State: AOJu0YxSnaKDrWtrWrDD/6IB06Al692fJOMBKbunLLRj3IUvpOPu12TR
	gHcY4/ZvvUfv07mh7xB6NjVu88k3Uomtgt5qaemt6EYcRcU=
X-Google-Smtp-Source: AGHT+IE6bkhCwFA0M4uwP+Lb6ZN8L2KrWR8HEAdhwiM9M7jAsFr4f+TtT4h4acyxAwWkGO404PMuXw==
X-Received: by 2002:a1c:6a17:0:b0:40e:53df:257b with SMTP id f23-20020a1c6a17000000b0040e53df257bmr625992wmc.153.1704894718352;
        Wed, 10 Jan 2024 05:51:58 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id bg3-20020a05600c3c8300b0040d91fa270fsm2280644wmb.36.2024.01.10.05.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 05:51:57 -0800 (PST)
Date: Wed, 10 Jan 2024 16:51:54 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: rostedt@goodmis.org
Cc: linux-trace-kernel@vger.kernel.org
Subject: [bug report] eventfs: Read ei->entries before ei->children in
 eventfs_iterate()
Message-ID: <1e7dd9d2-3b3c-4eb0-8c36-429a61d76743@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Steven Rostedt (Google),

The patch 704f960dbee2: "eventfs: Read ei->entries before
ei->children in eventfs_iterate()" from Jan 4, 2024 (linux-next),
leads to the following Smatch static checker warning:

	fs/tracefs/event_inode.c:775 eventfs_iterate()
	warn: missing error code here? 'create_file_dentry()' failed. 'ret' = '0'

fs/tracefs/event_inode.c
    749         /*
    750          * Need to create the dentries and inodes to have a consistent
    751          * inode number.
    752          */
    753         ret = 0;

Should this assignment be inside the loop?

    754 
    755         /* Start at 'c' to jump over already read entries */
    756         for (i = c; i < ei->nr_entries; i++, ctx->pos++) {
    757                 void *cdata = ei->data;
    758 
    759                 entry = &ei->entries[i];
    760                 name = entry->name;
    761 
    762                 mutex_lock(&eventfs_mutex);
    763                 /* If ei->is_freed then just bail here, nothing more to do */
    764                 if (ei->is_freed) {
    765                         mutex_unlock(&eventfs_mutex);
    766                         goto out;

On the second iteration through the loop then ret is an error code

    767                 }
    768                 r = entry->callback(name, &mode, &cdata, &fops);
    769                 mutex_unlock(&eventfs_mutex);
    770                 if (r <= 0)
    771                         continue;

that comes from r = entry->callback().  Except, hm, none of the callback
currently return anything except zero or one so it's not an issue yet.

    772 
    773                 dentry = create_file_dentry(ei, i, ei_dentry, name, mode, cdata, fops);
    774                 if (!dentry)
--> 775                         goto out;
    776                 ino = dentry->d_inode->i_ino;
    777                 dput(dentry);
    778 
    779                 if (!dir_emit(ctx, name, strlen(name), ino, DT_REG))
    780                         goto out;
    781         }
    782 
    783         /* Subtract the skipped entries above */
    784         c -= min((unsigned int)c, (unsigned int)ei->nr_entries);
    785 

regards,
dan carpenter
