Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF251BDC5
	for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Oct 2023 13:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZR/4dEum"
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A2BD55
	for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Oct 2023 06:52:37 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4083f61322fso6786605e9.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Oct 2023 06:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697809956; x=1698414756; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lj8TH5rSWG+7+IPUohBO3PRG8Gz3zP+8vz2fymGjsuc=;
        b=ZR/4dEum/rGkjTRummUxpWpc8CAokCtobkWPfCtSFsG5x78fSU8EuwkSiCWo9VKPAQ
         JmQQ3V8W0G7P42IPn2dLu/5QgbAh/mcGysrJoyr2+7fqnge6m54G2mE+XXNM7K+oDm5s
         wlTdCsBQFdbGIJ4DwZpQl+WK858thXYIVIBwq35lqfc4Rg8vPLIP6JVcr4cdRC5xMzwq
         n+O2aqXrhMtefT+JsTcY+NIKNSkxBvgccRJbDxhUrMHwYM2UJ8sU3QfFCBiScRpSFpuv
         TDaM/fihlFVqrnmXrrLIn8lqzymAkPzCOV1RowMcEeDU8h0YaPi/kBn4kG5WFPTHiqy+
         gTrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697809956; x=1698414756;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lj8TH5rSWG+7+IPUohBO3PRG8Gz3zP+8vz2fymGjsuc=;
        b=S85U1cTtpCVwVvoMA3NdjHwID+y+nNOgEpHxPJHnDeIGtjez3YvzVjkkGCnxQ6hXO/
         kNvdmF8MyMMiZANbCACzJaE4pYw2vOkP9zLlU7nQFgYSU1G/I3oRa5J7D/Nrhh4urRyK
         Cildf5WCymfP+msYmQLWtIbj2f2QVIXtT7AIRdYY8sk3TQSJ+ZuJvtn71DWuPp2y5vHP
         NB7fzzILTKQLDqSIcRNnBPx3/adVTwBm3C/BI2+hDveD9lKNzsM1nOzLJTHKglt2hW9R
         yAqt6innvWyvLhcRFo2CLn1P0CNKk/50gm6fa77i/KHp2bWmZTgmW5P6WbB++M8ab1Qp
         iIJw==
X-Gm-Message-State: AOJu0YzMGXzSwjp5GFcfdNDUZyh4HXuxcgDY8aMQglZ5gLCyyxU3qIBS
	C/ighwyPk59LsKLEKDlOFs0XJjxNS18hfNlo6xo=
X-Google-Smtp-Source: AGHT+IHn9qc+xrMAbz0V3HGAUl/wG6DW+YS6R1vSlbBV9XgLSBBxNJOIobdVtoNC59DmuMrwIJt33g==
X-Received: by 2002:a05:600c:5247:b0:406:4242:e7df with SMTP id fc7-20020a05600c524700b004064242e7dfmr1640353wmb.35.1697809955889;
        Fri, 20 Oct 2023 06:52:35 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id f9-20020adff449000000b0032d81837433sm1742443wrp.30.2023.10.20.06.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 06:52:35 -0700 (PDT)
Date: Fri, 20 Oct 2023 16:52:31 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: rostedt@goodmis.org
Cc: linux-trace-kernel@vger.kernel.org
Subject: [bug report] eventfs: Remove eventfs_file and just use eventfs_inode
Message-ID: <743deff8-0ae0-4c78-94d8-b926def66eb6@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Steven Rostedt (Google),

The patch 5790b1fb3d67: "eventfs: Remove eventfs_file and just use
eventfs_inode" from Oct 4, 2023 (linux-next), leads to the following
Smatch static checker warning:

	fs/tracefs/event_inode.c:782 eventfs_create_events_dir()
	error: potential null dereference 'ei'.  (kzalloc returns null)

fs/tracefs/event_inode.c
    721 struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry *parent,
    722                                                 const struct eventfs_entry *entries,
    723                                                 int size, void *data)
    724 {
    725         struct dentry *dentry = tracefs_start_creating(name, parent);
    726         struct eventfs_inode *ei;
    727         struct tracefs_inode *ti;
    728         struct inode *inode;
    729 
    730         if (security_locked_down(LOCKDOWN_TRACEFS))
    731                 return NULL;

I think these error paths should undo the tracefs_start_creating()
instead of returning directly.

    732 
    733         if (IS_ERR(dentry))
    734                 return (struct eventfs_inode *)dentry;

Same.

    735 
    736         ei = kzalloc(sizeof(*ei), GFP_KERNEL);
    737         if (!ei)
    738                 goto fail;

"ei" is NULL

    739 
    740         inode = tracefs_get_inode(dentry->d_sb);
    741         if (unlikely(!inode))
    742                 goto fail;
    743 
    744         if (size) {
    745                 ei->d_children = kzalloc(sizeof(*ei->d_children) * size, GFP_KERNEL);
    746                 if (!ei->d_children)
    747                         goto fail;
    748         }
    749 
    750         ei->dentry = dentry;
    751         ei->entries = entries;
    752         ei->nr_entries = size;
    753         ei->data = data;
    754         ei->name = kstrdup_const(name, GFP_KERNEL);
    755         if (!ei->name)
    756                 goto fail;
    757 
    758         INIT_LIST_HEAD(&ei->children);
    759         INIT_LIST_HEAD(&ei->list);
    760 
    761         ti = get_tracefs(inode);
    762         ti->flags |= TRACEFS_EVENT_INODE | TRACEFS_EVENT_TOP_INODE;
    763         ti->private = ei;
    764 
    765         inode->i_mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
    766         inode->i_op = &eventfs_root_dir_inode_operations;
    767         inode->i_fop = &eventfs_file_operations;
    768 
    769         /* directory inodes start off with i_nlink == 2 (for "." entry) */
    770         inc_nlink(inode);
    771         d_instantiate(dentry, inode);
    772         inc_nlink(dentry->d_parent->d_inode);
    773         fsnotify_mkdir(dentry->d_parent->d_inode, dentry);
    774         tracefs_end_creating(dentry);
    775 
    776         /* Will call dput when the directory is removed */
    777         dget(dentry);
    778 
    779         return ei;
    780 
    781  fail:
--> 782         kfree(ei->d_children);
                      ^^^^^^^^^^^^^^
Crash

    783         kfree(ei);
    784         tracefs_failed_creating(dentry);
    785         return ERR_PTR(-ENOMEM);
    786 }

regards,
dan carpenter
